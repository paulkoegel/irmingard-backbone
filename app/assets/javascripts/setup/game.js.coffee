IG.setupGame = ->
  IG.column_1 = new IG.Models.Column(_id: 1)
  _.each _.range(1, 10), (index) ->
    IG.column_1.get('cards').add new IG.Models.Card
      _id: index
      suit: 'clubs'
      value: index

  IG.column_2 = new IG.Models.Column(_id: 2)
  _.each _.range(1, 10), (index) ->
    IG.column_2.get('cards').add new IG.Models.Card
      _id: index
      suit: 'hearts'
      value: index

  IG.daColumnsCollection = new IG.Collections.Columns()
  IG.daColumnsCollection.add IG.column_1
  IG.daColumnsCollection.add IG.column_2

  _.times 7, (i) ->
    column = new IG.Models.Column(_id: i + 3)
    _.each _.range(1, 10), (index) ->
      column.get('cards').add new IG.Models.Card
        _id: index
        suit: 'spades'
        value: index
    IG.daColumnsCollection.add column

  IG.appLayout.content.show new IG.Views.ColumnsCollection(collection: IG.daColumnsCollection)
