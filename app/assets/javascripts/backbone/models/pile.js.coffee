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
