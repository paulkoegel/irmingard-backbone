'use strict'

class IG.Routers.AppRouter extends Backbone.Marionette.AppRouter
  initialize: ->

  routes:
    '': 'root'

  root: ->
    IG.column_1 = new IG.Models.Column
    _.each _.range(1, 10), (index) ->
      IG.column_1.get('cards').add new IG.Models.Card
        _id: index
        suit: 'clubs'
        value: index
