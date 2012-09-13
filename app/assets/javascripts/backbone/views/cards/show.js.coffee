'use strict'

class IG.Views.CardsShow extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'm-card'

  initialize: ->
    _.bindAll @, 'render'
    @template = 'cards/show'

  render: ->
    super()
    # set 'draggable' attribute on li.m-card
    $(@el).attr 'draggable', "#{@model.draggable()}"

  events:
    'dragstart': 'handleDragStart'
    'dragenter': 'handleDragEnter'
    'dragleave': 'handleDragLeave'
    'dragend': 'handleDragEnd'


  getDragTarget: ($dragEventTarget) ->
    if $dragEventTarget.hasClass('m-card')
      $dragTarget = $dragEventTarget
    else
      $parent = $dragEventTarget.parent('.m-card')
      if $parent.length
        $dragTarget = $parent
    $dragTarget

  handleDragStart: (event) ->
    return false unless @model.draggable()
    IG.currentlyDraggedCard = @model
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

  handleDragEnter: (event) ->
    # prevent dropping on self
    return if @model == IG.currentlyDraggedCard
    # prevent dropping on un-open cards
    return unless @model.isDropTargetFor(IG.currentlyDraggedCard)
    console.log '---'
    console.log IG.currentlyDraggedCard.humanReadableShort()
    console.log @model.humanReadableShort()
    #return unless event
    # $dragEventTarget = $(event.target)
    # console.log $dragEventTarget
    # if $dragEventTarget.hasClass('m-card')
    #   $dragTarget = $dragEventTarget
    # else
    #   $parent = $dragEventTarget.parent('.m-card')
    #   if $parent.length
    #     $dragTarget = $parent
    # console.log $dragTarget
    @getDragTarget($ event.target).addClass 'drop-hovered'

  handleDragLeave: (event) ->
    console.log 'leaving'
    console.log $(event.target)
    @getDragTarget($ event.target).removeClass 'drop-hovered'

    #console.log $(originalEvent.target)

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
