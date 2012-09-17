'use strict'

class IG.Views.PilesShow extends Backbone.Marionette.ItemView
  tagName: 'div'
  template: 'piles/show'

  initialize: ->
    _.bindAll @, 'render'
    @model.on 'add:cards', @render

  render: ->
    super()
    $(@el).addClass "m-pile_#{@model.get('suit')}"

  lastCard: ->
    @model.get('cards').last()

  serializeData: ->
    jsonData = @model.toJSON()
    if @lastCard()
      jsonData.lastCardValue = @lastCard().humanValue()
    jsonData.suitSymbol = @model.suitSymbol()
    jsonData
