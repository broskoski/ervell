sd = require('sharify').data
Backbone = require 'backbone'
markdown = require 'marked'
mediator = require '../../../lib/mediator.coffee'
CommentEditableAttributeView = require '../../editable_attribute/client/comment_editable_attribute_view.coffee'

template =-> require('../templates/index.jade') arguments...

module.exports = class CommentsView extends Backbone.View

  initialize: ->
    @collection.on 'sync add', @render, @

  render: ->
    @$el.html template md: markdown, comments: @collection

    @trigger 'render'

    @postRender()

    this

  postRender: ->
    # editable attribute
    @collection.each (comment) =>
      new CommentEditableAttributeView
        model: comment
        el: @$("#attribute-body_#{comment.id}")
        _attribute: 'body'
        _kind: 'markdown'
        wait: true
