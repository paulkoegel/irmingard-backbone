'use strict'

class IG.Routers.AppRouter extends Backbone.Marionette.AppRouter
  initialize: ->

  routes:
    '': 'root'

  root: ->
    IG.appLayout = new IG.AppLayout()
    IG.appLayout.render()
    IG.appLayout.header.show new IG.Views.Navigation()
    IG.setupGame()
