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
      key: 'column'
      includeInJSON: '_id'
  ]

  lastCard: ->
    @get('cards').last()
