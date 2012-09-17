'use strict'

class IG.Views.PilesShow extends Backbone.Marionette.ItemView
  tagName: 'ul'
  className: 'm-pile'
  template: 'piles/show'

  initialize: ->
    @collection = @model.get('cards')
    @itemView = IG.Views.CardsShow
