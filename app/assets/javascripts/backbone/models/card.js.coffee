'use strict'

# do NOT use class .. extends for RelationalModels, cf. https://github.com/PaulUithol/Backbone-relational#known-problems-and-solutions
IG.Models.Card = Backbone.RelationalModel.extend
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
    imagePath: null

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

  setImageAssetPath: (imageNamesHash) ->
    @set 'imagePath', imageNamesHash[@humanReadable()]

  suitSymbol: ->
    switch @get('suit')
      when 'diamonds'
        '♦'
      when 'hearts'
        '♥'
      when 'spades'
        '♠'
      when 'clubs'
        '♣'
      else
        null

  humanReadable: ->
    "#{@humanValue()}_of_#{@get('suit')}"

  humanReadableShort: ->
    "#{@suitSymbol()}#{@humanValue()}"

  short: ->
    @humanReadableShort()

  isDropTargetFor: (card) ->
    if @get('value') - 1 == card.get('value') and @colour() != card.colour()
      true
    else
      false

  isLastCardInColumn: (column) ->
    columnCardsCollection = column.get 'cards'
    columnCardsCollection.indexOf(@) == columnCardsCollection.length-1

  moveTo: (newColumn) ->
    if pile = @get('pile')
      pile.get('cards').remove @
    newColumn.get('cards').add @


  isDiscardableTo: (pilesCollection) ->
    piles = pilesCollection.pilesFor(@)
    cardValue = @.get('value')
    returnValue = false
    _.each piles, (pile) ->
      pileCards = pile.get('cards')
      if pileCards.length
        if pile.lastCard().get('value') == cardValue - 1
          returnValue = pile
      else if pileCards.length == 0 and cardValue == 1
        returnValue = pile
    return returnValue
