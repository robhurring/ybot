images = [
	'http://f.cl.ly/items/1w0Q2W0x0M0Y2h3l0z0q/6kgpJ.gif',
	'http://i.imgur.com/LwaAQ.gif',
	'http://assets0.ordienetworks.com/images/GifGuide/dancing/280sw007883.gif',
	'http://i365.photobucket.com/albums/oo96/ackleykida/l_b2d3c7b50c67f3302e20295bfa317f0b.gif',
	'http://i.imgur.com/rDDjz.gif',
	'http://i.imgur.com/8H266.gif',
	'http://i.imgur.com/4DbQ7.gif',
	'http://i.imgur.com/7Yt7J.gif',
	'http://i76.photobucket.com/albums/j10/Roxanna12347/clubbin.gif',
	'http://25.media.tumblr.com/tumblr_lwh4hjQd8c1r41m9ko1_500.gif',
	'http://27.media.tumblr.com/tumblr_lwj1xawtoM1qb7nmoo1_250.gif'
]

module.exports = (robot) ->
  robot.hear /\bclub\swes\b/i, (msg) ->
    msg.send msg.random images