module.exports = (robot) ->
  robot.hear /lyrify ((?:http:\/\/open.spotify.com\/(track|album|artist)\/|spotify:(track|album|artist):)\S+)/, (msg) ->
    spotify_uri = msg.match[1]

    getSpotify msg, spotify_uri, (data) ->
      if data?
        if data.info.type is "track"
          getLyrics msg, data.track.name, data.track.artists[0].name, (lyrics) ->
            msg.send "#{lyrics.lyrics}\n#{lyrics.url}"
        else
          msg.reply "Can only lyrify spotify tracks, not #{data.info.type}s"
      else
        msg.reply "I couldn't find that track in spotify!"

getLyrics = (msg, song, artist, callback) ->
  msg.http("http://lyrics.wikia.com/api.php")
    .query(artist: artist, song: song, fmt: "json")
    .get() (err, res, body) ->
      result = eval body # can't use JSON.parse :(
      callback result

getSpotify = (msg, link, callback) ->
  msg.http("http://ws.spotify.com/lookup/1/.json?uri=#{link}")
    .get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        callback data
      else
        callback null