'use strict'

class IG.Views.PilesShow extends Backbone.Marionette.ItemView
  tagName: 'div'
  className: 'm-pile'
  template: 'piles/show'

  initialize: ->
    _.bindAll @, 'render'
    @model.on 'add:cards', @render

  lastCard: ->
    @model.get('cards').last()

  serializeData: ->
    jsonData = @model.toJSON()
    if @lastCard()
      jsonData.lastCard = @lastCard().short()
    else
      jsonData.lastCard = 'Wumbaa'
    jsonData
