#
# Routes for about home and about panel
#

@home = (req, res, next) ->
  res.render "index", title: "About"

@page = (req, res, next) ->
  res.render req.params.page

