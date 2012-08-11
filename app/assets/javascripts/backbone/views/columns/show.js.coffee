'use strict'

class IG.Views.ColumnsShow extends Backbone.Marionette.CompositeView
  tagName: 'ul'
  className: 'column'
  itemView: IG.Views.CardsShow
  template: 'columns/show'
  itemViewContainer: '.column-wrapper'
