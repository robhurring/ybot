module.exports = (robot) ->
  robot.hear /(diplomatic immunity|been revoked)/, (msg) ->
    msg.send 'http://images.dailyfill.com/e30521b009d943cd_b8a40f3821f3ece8/o/9.jpg'
