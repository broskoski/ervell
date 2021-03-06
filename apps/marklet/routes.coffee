{ parse } = require 'url'
validator = require 'validator'
Backbone = require 'backbone'

class TabState extends Backbone.Model
  defaults: mode: 'url'

@save = (req, res, next) ->
  unless req.user
    return res.redirect "/log_in?redirect_uri=#{req.url}"

  res.locals.sd.SAVE = true
  res.locals.sd.CONTENT = content = req.params.content
  res.locals.sd.QUERY = query = req.query
  res.locals.sd.IS_URL = isURL = validator.isURL content

  res.render 'index',
    content: content
    isURL: isURL
    tab: new TabState()
    query: query
