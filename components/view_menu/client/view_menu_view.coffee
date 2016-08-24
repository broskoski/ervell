_ = require 'underscore'
sd = require("sharify").data
Backbone = require 'backbone'
mediator = require '../../../lib/mediator.coffee'
analytics = require '../../../lib/analytics.coffee'
DropdownView = require '../../dropdown/client/dropdown_view.coffee'

template = -> require('../templates/index.jade') arguments...

module.exports = class UserMenuView extends Backbone.View
  glyphs:
    grid: 'grid-three-up'
    list: 'list'

  events:
    'tap .view-menu__dropdown__option' : 'switchMode'
    'tap .js-dropdown-trigger' : 'toggleView'

  toggleView: (e) =>
    mode = if @model.get('view_mode') is 'list' then 'grid' else 'list'
    @_setMode mode

  switchMode: (e) ->
    @_setMode $(e.currentTarget).data 'mode'

  _setMode: (mode)->
    return unless mode is 'list' or mode is 'grid'
    @model.set view_mode: mode
    @$el.removeClass 'dropdown--is_active'
    @$('.view-menu__selected').attr 'data-glyph', @glyphs[mode]
    window.location.reload()