'use strict'

class IG.Models.Card extends Backbone.RelationalModel
  idAttribute: '_id'
  urlRoot: '/cards'
  defaults:
    _id:       null
    deck:      null
    suit:      null
    value:     null
    column:    null
    pile:      null
    stack:     true
    position:  null
    open:      false
    draggable: false
    backImagePath: '/assets/back.gif'

  initialize: (attributes) ->

  colour: ->
    if (@get('suit') == 'diamonds') or (@get('suit') == 'hearts')
      'red'
    else
      'black'

  humanValue: ->
    switch @get('value')
      when 1
        'ace'
      when 11
        'jack'
      when 12
        'queen'
      when 13
        'king'
      else
        @get('value') + ''

  setSlug: ->
    @set 'slug', "#{@get 'suit'}_#{@humanValue()}_#{@get 'deck'}"

  suitSymbol: ->
    switch @get('suit')
      when 'diamonds'
        '♦'
      when 'hearts'
        '♥'
      when 'spades'
        '♠'
      when'clubs'
        '♣'
      else
        null

  humanReadable: ->
    "#{@humanValue()}_of_#{@get('suit')}"

  humanReadableShort: ->
    "#{@suitSymbol()}#{@humanValue()}"

  short: ->
    @humanReadableShort()

  imagePath: ->
    "/assets/#{@humanReadable()}.gif"

  isDropTargetFor: (card) ->
    if @get('value') - 1 == card.get('value') and @colour() != card.colour()
      true
    else
      false

  isLastCardInColumn: (column) ->
    columnCardsCollection = column.get 'cards'
    columnCardsCollection.indexOf(@) == columnCardsCollection.length-1

  moveTo: (newColumn) ->
    oldColumn = @get('column')
    oldColumn.get('cards').remove @
    newColumn.get('cards').add @
