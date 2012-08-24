'use strict'

class IG.Models.Card extends Backbone.Model
  urlRoot: '/cards'
  defaults:
    suit: null
    value: null

  initialize: (attributes) ->
