IG.setupApp = ->

  IG.appRouter = new IG.Routers.AppRouter()

  Backbone.history.start
    pushState: true
