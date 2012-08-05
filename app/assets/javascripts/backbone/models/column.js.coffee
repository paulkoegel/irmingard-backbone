'use strict'

class IG.Models.Column extends Backbone.RelationalModel
  idAttribute: '_id'
  urlRoot: '/columns'
  defaults:
    _id: null
  relations: [
    type: Backbone.HasMany
    key: 'cards'
    relatedModel: 'IG.Models.Card'
    reverseRelation:
      key: 'column'
      includeInJSON: '_id'
  ]

  initialize: (attributes) ->
