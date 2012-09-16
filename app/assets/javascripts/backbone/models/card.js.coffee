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

  # draggable: ->
  #   #console.log @get 'open'
  #   isOpen = @get 'open'
  #   return false unless isOpen
  #   #console.log @
  #   #console.log @get 'column'
  #   column = @get 'column'
  #   # for SOME reason the cards column is empty when it's rendered by the Column's add callback (Marionette automatically rerenders the Column on add)
  #   return false unless column
  #   columnCardsCollection = column.get('cards')
  #   if @isLastCardInColumn(@get 'column')
  #     true
  #   else
  #     false

  humanReadable: ->
    "#{@humanValue()}_of_#{@get('suit')}"

  humanReadableShort: ->
    "#{@suitSymbol()}#{@humanValue()}"

  imagePath: ->
    "/assets/#{@humanReadable()}.gif"

  isDropTargetFor: (card) ->
    if @get('value') - 1 == card.get('value') and @colour() != card.colour()
      true
    else
      false

  isLastCardInColumn: (column) ->
    columnCardsCollection = column.get 'cards'
    x = (columnCardsCollection.indexOf(@) == columnCardsCollection.length-1)
    console.log "#{x}, #{columnCardsCollection.indexOf(@)} of #{columnCardsCollection.length-1}"
    x

  moveTo: (newColumn) ->
    oldColumn = @get('column')
    console.log 'starting to move'
    oldColumn.get('cards').remove @
    console.log 'done removing'
    newColumn.get('cards').add @
    console.log 'done adding'
