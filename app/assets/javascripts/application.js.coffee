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

# LOADING SEQUENCE IS IMPERATIVE HERE!
# columns/show MUST be loaded before columns/collection, unless you want to set itemView on initialization (not really the conventional pattern, so I'm rather biting this loading sequence bullet)
#= require_directory ./backbone/views/navigation
#= require_directory ./backbone/views/games
#= require_directory ./backbone/views/cards
#= require ./backbone/views/columns/show
#= require ./backbone/views/columns/collection

#= require_tree ./backbone/routers
#= require_tree ./backbone/controllers

#= require_tree .
