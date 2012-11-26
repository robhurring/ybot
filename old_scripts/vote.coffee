# Description:
#   Vote counter
#
# Commands:
#   hubot poll me <what> - Create a poll
#   hubot polls - A list of open polls
#   hubot close poll <poll-id> - Close the current poll
#   hubot vote <poll-id> (+ or -) - Vote in the poll

class VoteBot
  constructor: (@robot) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.vote_bot
        @cache = @robot.brain.data.vote_bot

  flushCache: ->
    @robot.brain.data.vote_bot = @cache

  addPoll: (question) ->
    @cache.push {question: question, tally: 0, votes: 0, percent: 0}
    @flushCache()
    id = @cache.length
    id

  rm: (id) ->
    poll = @get(id)
    if poll?
      @cache.splice (id - 1), 1
    @flushCache()

  get: (id) ->
    @cache[id - 1] if id >= 1

  vote: (id, add = true) ->
    poll = @get(id)
    if poll?
      if add
        poll.tally += 1
      else
        poll.tally -= 1
      poll.votes += 1
      poll.percent = (poll.tally / (poll.votes || 1) * 100)
    @flushCache()

  polls: ->
    @cache

module.exports = (robot) ->
  voteBot = new VoteBot robot

  robot.respond /close poll (\d+)/i, (msg) ->
    id = msg.match[1]
    poll = voteBot.get id
    if poll?
      voteBot.rm id
      output = []
      output.push "Closed Poll:\t\"#{poll.question}\""
      output.push "\t\tFinal Score: #{poll.tally} (#{poll.percent || '?'}% of #{poll.votes || '?'} votes)"
      msg.send output.join("\n")
    else
      msg.reply "There is no poll with ID #{id}."

  robot.respond /polls/i, (msg) ->
    output = []
    polls = voteBot.polls()

    if polls.length > 0
      for poll,id in polls
        do (poll, id) ->
          output.push "Poll #{id + 1}:\t\"#{poll.question}\""
          output.push "\t\t#{poll.tally} points from #{poll.votes || '?'} votes (#{poll.percent || '?'}%)"
          output.push "\t\t(Vote with: #{robot.name} vote #{id + 1} +/-)"

      msg.send output.join("\n")#, "\nVote with: #{robot.name} vote [ID] +/-"
    else
      msg.send "There aren't any polls!\nAdd one with: #{robot.name} poll me \"Question?\""

  robot.respond /vote (\d+) (\+|\-)/i, (msg) ->
    [id, pm] = [msg.match[1], msg.match[2]]
    poll = voteBot.get id

    if poll?
      voteBot.vote id, (pm == '+')
      msg.reply "\"#{poll.question}\" -> #{poll.tally} points"
    else
      msg.reply 'Poll does not exist!'

  robot.respond /poll me "([^"]+)"/i, (msg) ->
    question = msg.match[1]
    id = voteBot.addPoll question
    output = []
    output.push "\"#{question}\" is open for voting!"
    output.push "\tTo vote up:   #{robot.name} vote #{id} +"
    output.push "\tTo vote down: #{robot.name} vote #{id} -"
    # msg.reply "Poll added in slot #{id}, vote up or down using:", "For Yes: #{robot.name} vote #{id} +", "For No: #{robot.name} vote #{id} -"
    msg.send output.join("\n")
