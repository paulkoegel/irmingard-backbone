'use strict'

# override Marionette's Renderer.render to allow usage of JST templates (HAML coffee in our case)
# cf. https://github.com/derickbailey/backbone.marionette/wiki/Using-jst-templates-with-marionette
Backbone.Marionette.Renderer.render = (template, data) ->
  throw "Template '" + template + "' not found!" unless JST[template]
  JST[template](data)

# initialise app and set namespace
window.IG = new Backbone.Marionette.Application()

$ ->
  IG.start()

IG.Models      = {}
IG.Collections = {}
IG.Routers     = {}
IG.Views       = {}
IG.Controllers = {}

IG.vent = new Backbone.Marionette.EventAggregator()

class IG.AppLayout extends Backbone.Marionette.Layout
  template: 'layouts/application'
  el: 'body'
  regions:
    header:  '#l-header-container'
    content: '#l-content-container'

IG.addInitializer (option) ->
  IG.setupApp()
