'use strict'

class IG.Views.GamesShow extends Backbone.Marionette.ItemView
  tagName: 'div'
  id: 'game'

  initialize: ->
    _.bindAll @, 'render'
    @template = JST['games/show']

  render: ->
    $(@el).html(@template())
    @
