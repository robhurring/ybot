# Description:
#   Listens for links and fetches the webpage title
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect: "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   robhurring

Select      = require('soupselect').select
HTMLParser  = require 'htmlparser'
util = require 'util'

title_not_found_message = "Could not find the title for this link"
include_url_after_ms = 5000

module.exports = (robot)->
  robot.hear /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i, (msg) ->
    url = msg.match[1]
    return if url.match(/\.(png|jpg|jpeg|gif)$/) # avoid titles on images

    started = new Date

    lookup_title msg, url, (title) ->
      elapsed = parseInt((new Date) - started)
      include_url_with_title = (elapsed >= include_url_after_ms)

      if title?
        output = ["Page Title: #{title}"]
        output.push url if include_url_with_title
        msg.send output.join("\n")
      else
        msg.send title_not_found_message if title_not_found_message?

  lookup_title = (msg, url, callback) ->
    msg.http(url).get() (e, r, b) ->
      if r.statusCode == 302
        url = r.headers['location']
        return lookup_title msg, url, callback

      title = null
      element = get_selector(b, 'title')

      if element.length
        title = element[0].children[0].raw

      callback title

  get_selector = (body, selector) ->
    handler  = new HTMLParser.DefaultHandler (()->)
    parser   = new HTMLParser.Parser handler
    parser.parseComplete body
    Select(handler.dom, selector)
