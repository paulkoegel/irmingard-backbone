'use strict'

class IG.Models.Card extends Backbone.RelationalModel
  idAttribute: '_id'
  urlRoot: '/cards'
  defaults:
    _id: null
    suit: null
    value: null

  initialize: (attributes) ->
