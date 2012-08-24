'use strict'

class IG.Views.ColumnsCollection extends Backbone.Marionette.CompositeView
  tagName: 'div'
  className: 'columns-container'
  template: 'columns/collection'
  itemView: IG.Views.ColumnsShow
  itemViewContainer: '.columns-wrapper'
