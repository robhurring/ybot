module.exports = (robot) ->
	robot.respond /tell (\w+)(?:\sto|:)? (?:"?([^"]+)"?)/i, (msg) ->
		[userName, message] = msg.match[1..2]
		message = message.replace /^\s*/, ''
		users = robot.usersForFuzzyName userName
		
		if users.length > 0
			user = users[0]
			msg.send "#{user.name}: #{message}"
		else
			msg.reply "I can't find #{userName}!"