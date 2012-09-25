'use strict'

class IG.Views.StackShow extends Backbone.Marionette.ItemView
  tagName: 'button'
  className: 'serve-new-cards'
  template: 'stack/show'

  onRender: ->
    $(@el).attr 'title', 'Stuck? Serving additional cards from the stack might help!'
