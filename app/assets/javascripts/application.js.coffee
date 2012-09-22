#= require jquery
#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require backbone.marionette-0.9.10-dev
#= require backbone-relational-0.6.0

#= require_tree ./templates

#= require initialisation
#= require setup/app
#= require setup/game
#= require_tree ./backbone/models
#= require_tree ./backbone/collections

#= require_directory ./backbone/views/navigation
#= require_directory ./backbone/views/games
#= require_directory ./backbone/views/cards
#= require_directory ./backbone/views/columns

#= require_tree ./backbone/routers
#= require_tree ./backbone/controllers

#= require jquery_events

#= require_tree .
