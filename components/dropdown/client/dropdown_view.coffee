_ = require 'underscore'
sd = require('sharify').data
Backbone = require 'backbone'
mediator = require '../../../lib/mediator.coffee'

module.exports = class DropdownView extends Backbone.View
  openInterval: 100
  closeInterval: 200

  events:
    'mouseover' : 'onMouseOver'
    'mouseout' : 'onMouseOut'

  initialize: ->
    mediator.on 'search:loaded', @closeDropdown, @
    mediator.on 'body:click', @onBodyClick, @

  openDropdown: =>
    @$el.addClass 'dropdown--is_active'

  closeDropdown: (e) =>
    @$el.removeClass 'dropdown--is_active' unless @$el.is(':hover')

  onMouseOver: =>
    @openTimeoutId = setTimeout (=>
        $('.dropdown--is_active').removeClass 'dropdown--is_active'
        @openDropdown()
        @$('input').focus()
      ), @openInterval
    clearTimeout @timeoutId

  onMouseOut: (e) =>
    @closeTimeoutId = setTimeout @closeDropdown, @closeInterval
    clearTimeout @openTimeoutId

  onBodyClick: (e) =>
    if !e or
      (
        !@$el.is(e.target) and
        @$el.has(e.target).length is 0 and
        !$(e.target).hasClass 'trigger-mediator'
      )
        @closeDropdown() if @$el
