'use strict'

# override Marionette's Renderer.render to allow usage of JST templates (HAML coffee in our case)
# cf. https://github.com/derickbailey/backbone.marionette/wiki/Using-jst-templates-with-marionette
Backbone.Marionette.Renderer.render = (template, data) ->
  throw "Template '" + template + "' not found!" unless JST[template]
  JST[template](data)

# initialise app and set namespace
window.IG = new Backbone.Marionette.Application()

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
    header: '.l-header-container'
    content: '.l-content-container'

IG.addInitializer (option) ->
  IG.appRouter = new IG.Routers.AppRouter()

  Backbone.history.start
    pushState: true

  IG.appLayout = new IG.AppLayout()
  IG.appLayout.render()
  IG.appLayout.header.show new IG.Views.Navigation()

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

$ ->
  IG.start()
