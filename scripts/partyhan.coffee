module.exports = (robot) ->
  robot.hear /partyhan/i, (msg) ->
    msg.send 'http://f.cl.ly/items/0U1f1N3y1g1S3J2Q0346/partyhan.gif'
