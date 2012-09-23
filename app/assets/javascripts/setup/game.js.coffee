IG.setupGame = ->

  IG.piles = new IG.Collections.Piles()
  suits = ['diamonds', 'diamonds', 'spades', 'spades', 'hearts', 'hearts', 'clubs', 'clubs']
  _.each suits, (suit) ->
    IG.piles.add new IG.Models.Pile(suit: suit)

  IG.stack =  new IG.Models.Stack(_id: 1)
  decks = ['a', 'b']
  suits = ['diamonds', 'spades', 'hearts', 'clubs']
  cardsPerSuit = 13

  _.each decks, (deck) ->
    _.each suits, (suit) ->
      _.times cardsPerSuit, (index) ->
          card = new IG.Models.Card
            deck: deck
            suit: suit
            value: index+1
            column: null
            pile: null
            stack: true
            position: IG.stack.get('cards').length
          card.setSlug()
          card.setImageAssetPath(gon.image_paths)
          IG.stack.get('cards').add card

  IG.stack.shuffle()

  IG.columns = new IG.Collections.Columns()
  _.each [1, 2, 3, 4, 5, 4, 3, 2, 1], (cardsPerColumn, columnIndex) ->
    column = new IG.Models.Column(_id: columnIndex)
    IG.columns.add column
    _.times cardsPerColumn, (cardIndex) ->
      cardToAdd = IG.stack.get('cards').pop(silent: true)
      if cardIndex + 1 == cardsPerColumn
        cardToAdd.set
          'open': true
          'draggable': true
      column.get('cards').add cardToAdd, silent: true

  IG.appLayout.content.show new IG.Views.ColumnsCollection(collection: IG.columns)
  IG.appLayout.piles.show new IG.Views.PilesCollection(collection: IG.piles)
  # has to happen here to display counter on 'Hit me!' button
  IG.appLayout.header.show new IG.Views.NavigationShow()
