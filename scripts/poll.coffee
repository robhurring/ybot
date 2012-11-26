# Description:
#   Polling is in season amirite?
#
# Commands:
#   hubot poll me "<question>" - Opens a poll for the given question
#   hubot vote "<answer>" - Submit an answer for the open poll
#   hubot poll - Show the current open poll status
#   hubot close poll - Closes the current poll and ouputs the results

_ = require 'underscore'

class PollManager
  constructor: (@robot) ->
    @poll = null
    @robot.brain.on 'loaded', =>
      @load()

  load: ->
    if @robot.brain.data.poll?
      @poll = new Poll @robot.brain.data.poll

  save: ->
    if @poll?
      @robot.brain.data.poll = @poll.toJSON()
    else
      @robot.brain.data.poll = null

  currentPoll: -> @poll

  addAnswer: (answer) ->
    if @poll?
      @poll.addAnswer answer
      @save()

  closePoll: ->
    @poll = null
    @save()

  startPoll: (question) ->
    attributes =
      question: question
      answers: {}

    @poll = new Poll attributes
    @save()
    @poll

class Poll
  constructor: (@attributes) ->

  question: -> @attributes.question || '?'

  answers: -> @attributes.answers || {}

  addAnswer: (answer) ->
    @attributes.answers[answer] ||= 0
    @attributes.answers[answer] += 1

  sortedAnswers: ->
    answer_list = _.map @answers(), (score, answer) -> [score, answer]
    answer_list = _.sortBy answer_list, (item) -> item[0]
    return answer_list.reverse()

  topVote: ->
    answer_list = @sortedAnswers()
    if answer_list.length then answer_list[0] else null

  toJSON: ->
    @attributes

  toString: ->
    output = []
    answer_list = @sortedAnswers()

    output.push "Poll: \"#{@question()}\""
    if answer_list.length
      output.push "Votes:"
      for [score, answer], index in answer_list
        output.push "  - #{score} votes for \"#{answer}\""
    else
      output.push "  - No votes!"
    output.join("\n")

# chat interface
module.exports = (robot) ->
  manager = new PollManager robot

  robot.respond /poll me "?([^"]+)"?/i, (msg) ->
    question = msg.match[1]
    poll = manager.currentPoll()

    if poll?
      msg.send "There is a poll already open:\n\"#{poll.question()}\" is open for voting!"
    else
      poll = manager.startPoll question
      msg.send "\"#{poll.question()}\" is open for voting!\nVote with \"#{robot.name} vote <your-answer>\""

  robot.respond /poll$/i, (msg) ->
    poll = manager.currentPoll()

    if poll?
      msg.send poll.toString()
    else
      msg.send "No poll is in progress."

  robot.respond /close poll/i, (msg) ->
    poll = manager.currentPoll()
    manager.closePoll()

    if poll?
      output = []
      output.push "--- The polls have closed! ---"
      output.push poll.toString()

      if poll.topVote()?
        [score, answer]  = poll.topVote()
        output.push "--- The winner is \"#{answer}\" ---"

      msg.send output.join("\n")
    else
      msg.send "There is no poll to close!\nOpen one with \"#{robot.name} poll me <question>\""

  robot.respond /vote "?([^"]+)"?/i, (msg) ->
    answer = msg.match[1]
    poll = manager.currentPoll()

    if poll?
      manager.addAnswer answer
      msg.reply "Your vote has been cast.\nUse \"#{robot.name} poll\" to see the current standings."
    else
      msg.send "There is no poll to close!\nOpen one with \"#{robot.name} poll me <question>\""
