'use strict'

# do NOT use class .. extends for RelationalModels, cf. https://github.com/PaulUithol/Backbone-relational#known-problems-and-solutions
IG.Models.Pile = Backbone.RelationalModel.extend
  idAttribute: '_id'
  urlRoot: '/piles'

  defaults:
    _id:  null
    suit: null

  relations: [
    type: Backbone.HasMany
    key: 'cards'
    relatedModel: 'IG.Models.Card'
    collectionType: 'IG.Collections.Cards'
    reverseRelation:
      key: 'pile'
      includeInJSON: '_id'
  ]

  initialize: ->
    @on 'add:cards', @handleAdd

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

  lastCard: ->
    @get('cards').last()

  handleAdd: (addedCard, cardsCollection) ->
    IG.gameWon.call($('body'), IG.gameWonParameters) if @allPilesFull()

  allPilesFull: ->
    pileLengths = IG.piles.map (pile) ->
      pile.get('cards').length
    _.reduce pileLengths, (memo, pileLength) ->
      memo = memo && (pileLength == 13)
    , true
