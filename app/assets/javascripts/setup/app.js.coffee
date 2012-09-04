IG.setupApp = ->
  IG.appRouter = new IG.Routers.AppRouter()

  Backbone.history.start
    pushState: true

  IG.appLayout = new IG.AppLayout()
  IG.appLayout.render()
  IG.appLayout.header.show new IG.Views.Navigation()
