# Commands:
#   hubot excuse me   - Get an developer excuse

Select     = require("soupselect").select
HtmlParser = require "htmlparser"

module.exports = (robot) ->
  robot.respond /excuse me/i, (msg) ->
    excuseMe msg, (excuse) ->
      msg.send excuse

excuseMe = (msg, cb) ->
  msg.http("http://programmingexcuses.com")
    .get() (err, res, body) ->
      handler = new HtmlParser.DefaultHandler()
      parser  = new HtmlParser.Parser handler
      parser.parseComplete body
      nodes = Select(handler.dom, '.wrapper center a')
      cb nodes[0]?.children[0]?.data || false
