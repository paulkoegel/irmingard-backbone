IG.setupGame = ->
  IG.stack =  new IG.Models.Stack(_id: 1)
  decks = ['a', 'b']
  suits = ['diamonds', 'hearts', 'spades', 'clubs']
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
          IG.stack.get('cards').add card
  IG.stack.shuffle()

  IG.columns = new IG.Collections.Columns()
  _.each [1, 2, 3, 4, 5, 4, 3, 2, 1], (cardsPerColumn, columnIndex) ->
    column = new IG.Models.Column(_id: columnIndex)
    IG.columns.add column
    _.times cardsPerColumn, ->
      column.get('cards').add IG.stack.get('cards').pop(silent: true)
    column.get('cards').models[column.get('cards').length-1].set('open', true)

  IG.appLayout.content.show new IG.Views.ColumnsCollection(collection: IG.columns)
