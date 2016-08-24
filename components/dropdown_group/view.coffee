Backbone = require 'backbone'
mediator = require '../../lib/mediator.coffee'
NewChannelView = require '../new_channel/client/new_channel_view.coffee'
UserMenuView = require '../user_menu/client/user_menu_view.coffee'
ViewMenuView = require '../view_menu/client/view_menu_view.coffee'
NotificationsView = require '../notifications_menu/client/notifications_view.coffee'

module.exports = class DropdownGroupView extends Backbone.View
  interval: 200

  mobileEvents:
    'tap .js-dropdown-trigger' : 'toggleDropdown'

  initialize: ->
    mediator.on 'search:loaded', @closeDropdown, @
    mediator.on 'body:click', @onBodyClick, @

    @setEvents()

  setEvents: ->
    @setupSubViews()

    if $('body').hasClass 'is-mobile'
      @undelegateEvents()
      @delegateEvents(@mobileEvents)
    else
      @setupMenuAim()

  setupSubViews: ->
    if mediator.shared.current_user.id
      new UserMenuView
        el: $('.dropdown--menu--user')
      new NewChannelView
        el: $('.dropdown--menu--new-channel')
      new NotificationsView
        el: $('.dropdown--menu--notifications')

    if mediator.shared.current_user.get('is_pro')
      new ViewMenuView
        el: $('.dropdown--menu--view')
        model: mediator.shared.state

  setupMenuAim: ->
    @$el.menuAim
      activate: (el) -> $(el).addClass 'dropdown--is_active'
      deactivate: (el) -> $(el).removeClass 'dropdown--is_active'
      exit: (el) -> $('.dropdown--is_active').removeClass 'dropdown--is_active'
      rowSelector: "> .dropdown--menu"
      submenuDirection: "below"