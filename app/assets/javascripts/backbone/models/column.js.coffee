'use strict'

# can't use 'class .. extends' here since it breaks Backbone relational's reverseRelation, cf. https://github.com/PaulUithol/Backbone-relational#known-problems-and-solutions
IG.Models.Column = Backbone.RelationalModel.extend
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
    @on 'remove:cards', @handleRemove
    @on 'add:cards', @handleAdd

  handleRemove: (removedCard, cardsCollection) ->
    # do nothing if removed Card was last in Column
    return unless cardsCollection.length
    lastCard = cardsCollection.last()
    lastCard.set 'open', true, silent: true
    lastCard.set 'draggable', true

  handleAdd: (movedCard, cardsCollection) ->
    # TODO refactor! this is rather inefficient
    cardsCollection.each (card) ->
      card.set('draggable', false)
    _.each @draggableCards(), (draggableCard) ->
      unless draggableCard.get 'draggable'
        draggableCard.set 'draggable', true

  orderedUpToIndex: ->
    cards = @get('cards').toArray().reverse()
    index = 0
    while index < cards.length-1
      if cards[index+1].isDropTargetFor(cards[index])
        index++
      else break
    return index

  draggableCards: ->
    cards = @get('cards')
    # minus to start from the end of the array, +1 since -1 and not 0 is the first index when starting at the end of the array
    cards.toArray().slice -(@orderedUpToIndex()+1)

  cardsBelow: (card) ->
    cards = @get('cards')
    startIndex = cards.indexOf(card)
    cards.toArray()[startIndex+1 .. cards.length]
