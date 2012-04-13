class VoteBot
  constructor: (@robot) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.vote_bot
        @cache = @robot.brain.data.vote_bot

  flushCache: ->
    @robot.brain.data.vote_bot = @cache

  addPoll: (question) ->
    @cache.push {question: question, tally: 0}
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
      msg.send "Closed Poll: \"#{poll.question}\". Final Score: #{poll.tally}."
    else
      msg.reply "There is no poll with ID #{id}."

  robot.respond /polls/i, (msg) ->
    output = []
    polls = voteBot.polls()

    if polls.length > 0
      for poll,id in polls
        do (poll, id) ->
          output.push "[ID: #{id}] #{poll.question}: #{poll.tally} points."
      msg.send output.join("\n"), "\nVote with: #{robot.name} vote [ID] +/-"
    else
      msg.send "There aren't any polls!\nAdd one with: #{robot.name} poll me \"Question?\""

  robot.respond /vote (\d+) (\+|\-)/i, (msg) ->
    [id, pm] = [msg.match[1], msg.match[2]]
    poll = voteBot.get id
    
    if poll?
      voteBot.vote id, (pm == '+')
      msg.reply "#{poll.question}: #{poll.tally}"
    else
      msg.reply 'Poll does not exist!'

  robot.respond /poll me "([^"]+)"/i, (msg) ->
    question = msg.match[1]
    id = voteBot.addPoll question
    msg.reply "Poll added in slot #{id}, vote up or down using:", "For Yes: #{robot.name} vote 1 +", "For No: #{robot.name} vote 1 -"
