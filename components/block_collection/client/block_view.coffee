Backbone = require "backbone"
Backbone.$ = $
sd = require("sharify").data
mediator = require '../../../lib/mediator.coffee'
ConnectView = require '../../connect/client/connect_view.coffee'
IconicJS = require '../../../components/iconic/client/iconic.min.js'
FollowButtonView = require '../../follow_button/client/follow_button_view.coffee'
User = require '../../../models/user.coffee'
{ trackOutboundLink } = require '../../../lib/analytics.coffee'
analytics = require '../../../lib/analytics.coffee'

blockTemplate = -> require('../templates/block.jade') arguments...

module.exports = class BlockView extends Backbone.View
  autoRender: true
  container: null
  containerMethod: 'append'

  events:
    'click .grid__block__source__link'  : 'openLink'
    'click .grid__block__connect-btn'   : 'loadConnectView'
    'click .grid__block__delete-block'  : 'confirmDestroy'
    'click .confirm__choice__yes'       : 'destroyConnection'
    'click .confirm__choice__no'        : 'cancelDestroy'

  initialize: (options)->
    { @container, @autoRender, @containerMethod, @channel } = options

    @current_user = mediator.shared.current_user

    @render() if @autoRender
    @$el = $("##{@model.id}") unless @el
    @renderFollowButton()

    @delegateEvents()

    @model.on 'remote_update', @update, @
    @model.on 'show', @show, @
    @model.on 'hide', @hide, @

    mediator.on "model:#{@model.id}:updated", @update, @
    mediator.on "connection:#{@model.id}:complete", @removeActiveClass, @
    mediator.on "body:click", @removeActiveClass, @

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()

  loadConnectView: (e)=>
    e.preventDefault()
    e.stopPropagation()

    $connect_container = @$('.grid__block__connect-container')
    $connect_container.addClass 'is-active'
    @$('.grid__block__inner').addClass 'is-active'

    $connect_link = @$('.grid__block__link')
    $connect_link.attr('data-disabled', 'true')

    new ConnectView
      el: $connect_container
      block: @model

  openLink: (e)->
    analytics.track.click "Block source opened"

    url = @model.getSourceUrl()

    e.preventDefault()
    e.stopImmediatePropagation()
    trackOutboundLink url
    if @model.get('visibility') is 'private'
      site = window.open "#{sd.APP_URL}/go?redirect-to=#{url}", "_blank"
    else
      window.open url,'_blank'
      return false

  update: (model)->
    args =
      block: model
      user: @current_user

    args['channel'] = @channel if @channel?

    $("##{model.id}").replaceWith blockTemplate args
    @$el = $("##{model.id}")
    @model = model

    IconicJS().inject 'img.iconic'

    @renderFollowButton()
    @delegateEvents()

  removeActiveClass: (e)->
    return false unless !e or (!@$el.is(e.target) and @$el.has(e.target).length is 0)
    @$('.grid__block__inner').removeClass 'is-active'
    @$('.grid__block__link').removeAttr('data-disabled')

  render: ->
    if @containerMethod isnt 'before' and @containerMethod isnt 'after'
      @container[@containerMethod] blockTemplate
        block: @model
        user: @current_user
        channel: @channel
    else
      @container.find('.grid__block--new-block')[@containerMethod] blockTemplate
        block: @model
        user: @current_user
        channel: @channel

    @$el = $("##{@model.id}")

    @renderFollowButton()

  confirmDestroy: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    @$('.grid__block__delete-block__confirm, .grid__block__inner').addClass 'is-active'

  cancelDestroy: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    @$('.grid__block__delete-block__confirm, .grid__block__inner').removeClass 'is-active'

  destroyConnection: (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()

    @model.destroy
      channel: @channel

    analytics.track.click "Block removed from channel"

    @remove()

    e.preventDefault()
    e.stopPropagation()

  renderFollowButton: ->
    if @model.get('class') is 'Channel' or @model.get('class') is 'User' && sd.CURRENT_USER
      new FollowButtonView
        el: @$('.grid__block__follow_btn')
        model: @model
        showTitle: false
