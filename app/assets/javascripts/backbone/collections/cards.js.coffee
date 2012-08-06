'use strict'

class IG.Collections.Cards extends Backbone.Collection
  url: '/cards'
  model: IG.Models.Card
