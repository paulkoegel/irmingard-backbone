'use strict'

class IG.Views.NavigationShow extends Backbone.Marionette.ItemView
  tagName: 'nav'
  id: 'l-navigation'

  initialize: ->
    _.bindAll @, 'render'
    @template = JST['navigation/show']

  render: ->
    $(@el).html @template()
    @
