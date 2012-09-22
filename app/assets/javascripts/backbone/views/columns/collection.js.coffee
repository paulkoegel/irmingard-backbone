'use strict'

class IG.Views.ColumnsCollection extends Backbone.Marionette.CompositeView
  tagName: 'div'
  id: 'columns-container'
  template: 'columns/collection'
  itemViewContainer: '.columns-wrapper'

  initialize: ->
    # causes loading order issues when this is set as an attribute above
    @itemView = IG.Views.ColumnsShow
