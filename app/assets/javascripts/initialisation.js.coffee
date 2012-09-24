'use strict'

# override Marionette's Renderer.render to allow usage of JST templates (HAML coffee in our case)
# cf. https://github.com/derickbailey/backbone.marionette/wiki/Using-jst-templates-with-marionette
Backbone.Marionette.Renderer.render = (template, data) ->
  throw "Template '" + template + "' not found!" unless JST[template]
  JST[template](data)

# initialise app and set namespace
window.IG = new Backbone.Marionette.Application()

$ ->
  # hacky alternative to DOMNodeInserted, cf.: http://davidwalsh.name/detect-node-insertion
  insertListener = (event) ->
    if event.animationName == 'nodeInserted'
      $(event.target).removeClass 'off-the-board'

  # insertListener() MUST be declared before these
  document.addEventListener('animationstart', insertListener, false) # standard + Firefox
  document.addEventListener('webkitAnimationStart', insertListener, false) # Chrome + Safari
  document.addEventListener('MSAnimationStart', insertListener, false) # IE
  
  IG.start()

IG.Models      = {}
IG.Collections = {}
IG.Routers     = {}
IG.Views       = {}
IG.Controllers = {}

IG.vent = new Backbone.Marionette.EventAggregator()

class IG.AppLayout extends Backbone.Marionette.Layout
  template: 'layouts/application'
  el: '#l-game-container'
  regions:
    navigation:  '#l-header-container--navigation-wrapper'
    stack:   '#stack'
    piles:   '#l-piles-container'
    content: '#l-content-container'

IG.addInitializer (option) ->
  IG.setupApp()
