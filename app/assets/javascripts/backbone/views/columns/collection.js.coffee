'use strict'

class IG.Views.ColumnsCollection extends Backbone.Marionette.CompositeView
  tagName: 'div'
  id: 'columns-container'
  template: 'columns/collection'
  itemView: IG.Views.ColumnsShow
  itemViewContainer: '#columns-wrapper'
  initialize: ->
    @itemView = IG.Views.ColumnsShow

    _.bindAll @, 'render'
    console.log 'init ColumnsCollection view'
  render: ->
    console.log 'rendering columnsCollection view'
    console.log super
    #IG.Views.ColumnsShow(collection: @collection)
