gils = [
  'http://images.wikia.com/simpsons/images/1/12/Gil.gif',
  'http://1.bp.blogspot.com/_UwbGSxLEJcQ/SsDVj6CPE1I/AAAAAAAAAoY/PaNVfLG1Uf4/s400/gil+gunderson+los+simpsons.gif',
  'http://www.giantsfootballblog.com/wordpress/wp-content/uploads/2009/09/Gil-Simpsons-300x280.gif',
  'http://www.myfconline.com/character_avatars/71278_68841.jpg',
  'http://deadhomersociety.files.wordpress.com/2010/06/realtybites2.png',
  'http://i5.photobucket.com/albums/y189/jguy4life/Gil.gif',
  'http://cdn.follw.it/episodeimages/originals/3370/325923.jpg'
]

gil_phrases = [
  'that\'?s enough .+',
  'push your luck',
  'any leads',
  'wall from home',
  'not today',
  'shutup gil',
  'said it was over',
  'eating food tonight',
  'rick james bible',
  'hello fred'
]

gil_regex = new RegExp('.*(' + gil_phrases.join('|') + ').*')

module.exports = (robot) ->
  robot.hear gil_regex, (msg) ->
    msg.send msg.random gils
    