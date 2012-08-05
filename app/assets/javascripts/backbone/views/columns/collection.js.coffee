'use strict'

class IG.Views.ColumnsCollection extends Backbone.Marionette.CompositeView
  tagName: 'div'
  id: 'columns'

  initialize: ->
    _.bindAll @, 'render'
    @template = JST['columns/collection']

  render: ->
    $(@el).html @template()
    @
