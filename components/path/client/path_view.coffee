_ = require 'underscore'
sd = require('sharify').data
Backbone = require 'backbone'
Backbone.$ = $
mediator = require '../../../lib/mediator.coffee'
Block = require '../../../models/block.coffee'
User = require '../../../models/user.coffee'
FollowButtonView = require '../../follow_button/client/follow_button_view.coffee'
PrivateChannelView = require '../../private_channel/client/private_channel_view.coffee'

module.exports = class PathView extends Backbone.View

  initialize: (options) ->
    @setupSubViews()

  setupSubViews: ->
    if (sd.USER or sd.CHANNEL) and sd.CURRENT_USER
      new FollowButtonView
        el: @$('.follow_button')
        model: @model
        showTitle: no

      unless sd.CHANNEL
        new PrivateChannelView
          el: @$('.message_button')
          model: new User sd.USER
          showTitle: no
