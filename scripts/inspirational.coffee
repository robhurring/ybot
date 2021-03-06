# Commands:
#   hubot motivate me   - Get an inspirational quote
#   hubot demotivate me - Get a demotivational image
good = [
  'Storms make oaks take roots.',
  'If you do not hope, you will not find what is beyond your hopes.',
  'The only way of finding the limits of the possible is by going beyond them into the impossible.',
  'We are what we repeatedly do. Excellence, therefore, is not an act but a habit.',
  'Work spares us from three evils: boredom, vice, and need.',
  'If the wind will not serve, take to the oars.',
  'You cannot plough a field by turning it over in your mind.',
  'Fortune favors the brave.',
  'Innovate or die.',
  'Nothing great was ever achieved without enthusiasm.',
  'Constant dripping hollows out a stone.',
  'Every artist was first an amateur.',
  'You miss 100% of the shots you don\'t take.',
  'Even if you\'re on the right track, you will get run over if you\'re not moving',
  'Bondarylessness',
  'The journey of a thousand miles begins with a single step.',
  'When it is dark enough, you can see the stars',
  'Lots of things that couldn\'t be done have been done.',
  'There is no happiness except in the realization that we have accomplished something.',
  'The ability to convert ideas to things is the secret to outward success.'
]

bad = [
	'http://demotivators.despair.com/believeinyourselfdemotivator.jpg',
	'http://demotivators.despair.com/committeesdemotivator.jpg',
	'http://demotivators.despair.com/traditiondemotivator.jpg',
	'http://demotivators.despair.com/mistakesdemotivator.jpg',
	'http://demotivators.despair.com/mercydemotivator.jpg',
	'http://demotivators.despair.com/governmentdemotivator.jpg',
	'http://demotivators.despair.com/potentialdemotivator.jpg',
	'http://demotivators.despair.com/adaptationdemotivator.jpg',
	'http://demotivators.despair.com/collaborationdemotivator.jpg',
	'http://demotivators.despair.com/motivationdemotivator.jpg',
	'http://demotivators.despair.com/underachievementpenguindemotivator.jpg',
	'http://demotivators.despair.com/demotivationdemotivator.jpg',
	'http://demotivators.despair.com/legacydemotivator.jpg',
	'http://demotivators.despair.com/procrastinationdemotivator.jpg',
	'http://demotivators.despair.com/meetingsdemotivator.jpg',
	'http://demotivators.despair.com/indecisiondemotivator.jpg',
	'http://demotivators.despair.com/consultingdemotivator.jpg',
	'http://demotivators.despair.com/obstaclesdemotivator.jpg',
	'http://demotivators.despair.com/marketingdemotivator.jpg',
	'http://demotivators.despair.com/gettoworkdemotivator.jpg',
	'http://demotivators.despair.com/synergydemotivator.jpg',
	'http://demotivators.despair.com/perseverancedemotivator.jpg',
	'http://demotivators.despair.com/idiocydemotivator.jpg',
	'http://demotivators.despair.com/worthdemotivator.jpg',
	'http://demotivators.despair.com/ambitiondemotivator.jpg',
	'http://demotivators.despair.com/libertydemotivator.jpg',
	'http://demotivators.despair.com/teamworkdemotivator.jpg',
	'http://demotivators.despair.com/achievementdemotivator.jpg',
	'http://demotivators.despair.com/creativitydemotivator.jpg',
	'http://demotivators.despair.com/diversitydemotivator.jpg',
	'http://demotivators.despair.com/cluelessnessdemotivator.jpg',
	'http://demotivators.despair.com/challengesdemotivator.jpg',
	'http://demotivators.despair.com/acquisitiondemotivator.jpg',
	'http://demotivators.despair.com/incompetencedemotivator.jpg',
	'http://demotivators.despair.com/prioritiesdemotivator.jpg',
	'http://demotivators.despair.com/inflationdemotivator.jpg',
	'http://demotivators.despair.com/individualitydemotivator.jpg',
	'http://demotivators.despair.com/wisdomdemotivator.jpg',
	'http://demotivators.despair.com/maturitydemotivator.jpg',
	'http://demotivators.despair.com/hopedemotivator.jpg'
]

module.exports = (robot) ->
  robot.respond /\b(inspire|motivate)\b me/i, (msg) ->
    msg.reply msg.random good

  robot.respond /\b(demotivate|uninspire)\b me/i, (msg) ->
    msg.send msg.random bad