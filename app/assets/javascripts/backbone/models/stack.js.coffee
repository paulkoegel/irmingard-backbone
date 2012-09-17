'use strict'

IG.Models.Stack = Backbone.RelationalModel.extend
  idAttribute: '_id'
  urlRoot: '/stacks'

  defaults:
    _id: null

  relations: [
    type: Backbone.HasMany
    key: 'cards'
    relatedModel: 'IG.Models.Card'
    collectionType: 'IG.Collections.Cards'
    reverseRelation:
      key: 'stack'
      includeInJSON: '_id'
  ]

  initialize: (attributes) ->

  shuffle: ->
    @get('cards').reset _.shuffle(@get('cards').models)
