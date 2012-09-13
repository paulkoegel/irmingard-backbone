'use strict'

class IG.Views.CardsShow extends Backbone.Marionette.ItemView
  template: 'cards/show'
  tagName: 'li'
  className: 'm-card'

  render: ->
    $(@el).attr 'draggable', @model.draggable()
    super

  events:
    'dragstart .m-card[draggable="true"]': 'handleDragStart'
    'dragend .m-card[draggable="true"]': 'handleDragEnd'

  handleDragStart: (event) ->
    #event.stopPropagation()
    #event.preventDefault()
    console.log 'started dragging'
    $(@el).addClass 'low-opacity'
    event.dataTransfer = event.originalEvent.dataTransfer
    ##event.dataTransfer.setData("text/plain", "Text to drag")
    event.dataTransfer.effectAllowed = 'move'
    event.dataTransfer.setData 'text/html', @innerHTML
    #return false # required to get rid of ghost drag images

  handleDragEnd: (event) ->
    console.log 'stopped dragging'
    $(@el).removeClass 'low-opacity'

  # custom function to put some additional meat on 'this' used in the CardsShow template
  # manually adding the output of certain functions that would otherwise
  # not be accessible from the template
  # cf.: http://stackoverflow.com/a/10779124 and
  # http://derickbailey.github.com/backbone.marionette/docs/backbone.marionette.html
  serializeData: ->
    jsonData = @model.toJSON()
    jsonData.humanReadableShort = @model.humanReadableShort()
    jsonData.imagePath = @model.imagePath()
    jsonData.draggable = @model.draggable()
    jsonData
