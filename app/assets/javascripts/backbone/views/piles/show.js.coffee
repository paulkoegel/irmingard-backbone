'use strict'

class IG.Views.PilesShow extends Backbone.Marionette.CompositeView
  tagName: 'ul'
  className: 'm-pile'
  template: 'piles/show'

  initialize: ->
    _.bindAll @, 'render'
    @itemView = IG.Views.CardsShow
    @collection = @model.get('cards')

  render: ->
    super()
    $(@el).addClass "m-pile_#{@model.get('suit')}"

  lastCard: ->
    @collection.last()

  serializeData: ->
    jsonData = @model.toJSON()
    jsonData.suitSymbol = @model.suitSymbol()
    jsonData
