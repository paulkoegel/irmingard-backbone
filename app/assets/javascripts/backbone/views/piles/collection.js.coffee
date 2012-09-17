'use strict'

class IG.Views.PilesCollection extends Backbone.Marionette.CompositeView
  tagName: 'div'
  id: 'piles-container'
  template: 'piles/collection'
  itemViewContainer: '#piles-wrapper'
  
  initialize: ->
    @itemView = IG.Views.PilesShow
