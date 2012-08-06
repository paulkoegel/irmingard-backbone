'use strict'

class IG.Views.CardsShow extends Backbone.Marionette.ItemView
  tagName: 'li'
  class: 'card'
  template: 'cards/show'

  # initialize: ->
  #   _.bindAll @, 'render'
  #   @template = JST['cards/show']

  # render: ->
  #   $(@el).html @template(@model.toJSON())
  #   @
