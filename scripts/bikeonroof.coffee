# Description:
#   A bike on the roof. How does it work? When will it appear or disappear? Who knows!
#
module.exports = (robot) ->
  roof_bikes = [
    "http://f.cl.ly/items/0c2z3I3s1u031I0B3Z2D/bikeontheroof.jpg",
    "http://f.cl.ly/items/111J0u3N0V3C152y2Z1J/bikeontheroof2.png",
    "http://f.cl.ly/items/2v1V3V2O0R2x3h3A2z2u/bikeonroof3.png"
  ]

  robot.hear /bike on(?:\s*(?:a|the)\s*)? roof?/i, (msg) ->
    msg.send msg.random roof_bikes
