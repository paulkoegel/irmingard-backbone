'use strict'

class IG.Collections.Piles extends Backbone.Collection
  url: '/piles'
  model: IG.Models.Pile

  pilesFor: (card) ->
    @filter (pile) ->
      pile.get('suit') == card.get('suit')
