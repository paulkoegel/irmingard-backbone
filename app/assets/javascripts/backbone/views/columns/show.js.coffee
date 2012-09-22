'use strict'

class IG.Views.ColumnsShow extends Backbone.Marionette.CompositeView
  tagName: 'ul'
  className: 'm-column'
  template: 'columns/show'

  #cf. http://stackoverflow.com/a/11354636
  initialize: ->
    @itemView = IG.Views.CardsShow
    @collection = @model.get('cards')
