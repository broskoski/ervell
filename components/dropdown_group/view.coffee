Backbone = require 'backbone'
mediator = require '../../lib/mediator.coffee'
NewChannelView = require '../new_channel/client/new_channel_view.coffee'
UserMenuView = require '../user_menu/client/user_menu_view.coffee'
ViewMenuView = require '../view_menu/client/view_menu_view.coffee'
NotificationsView = require '../notifications_menu/client/notifications_view.coffee'

module.exports = class DropdownGroupView extends Backbone.View

  initialize: ->
    @$el.menuAim
      rowSelector: '.dropdown--menu'
      activate: (el) ->
        console.log 'activate', el
        $(el).addClass 'dropdown--is_active'
      deactivate: (el) ->
        console.log 'deactivate', el
        $(el).removeClass 'dropdown--is_active'
