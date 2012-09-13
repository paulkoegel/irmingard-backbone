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
    collectionType: 'IG.Collections.Cards'
    reverseRelation:
      key: 'column'
      includeInJSON: '_id'
  ]

  initialize: (attributes) ->
    @on 'add:cards remove:cards', @updateDraggability

  updateDraggability: (movedCard, cardsCollection) ->
    console.log "updating draggability for column: #{@get('_id')}"
