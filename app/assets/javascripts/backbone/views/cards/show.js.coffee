'use strict'

class IG.Views.CardsShow extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'm-card'

  initialize: ->
    _.bindAll @, 'render'
    @template = 'cards/show'
    @model.on 'change:open change:draggable', @render
    @model.on 'change:draggable', @setDraggable
    @setDraggable()

  onRender: ->
    # A card added via 'Hit me!' doesn't have a column set for Backbone Relational on render - that's how we distinguish them from the last card of a column, which also gets rerendered (to update draggability) when a new card is added to a column. We don't want to run an animation when a card is added to a column via drag and drop.
    # This doesn't fix the problem for Piles, though. To show cards there, we're simply using the power of CSS. .off-the-board only sets top to 700px for cards nested within .m-column
    # TODO: remaining problem: card pulled back to the board form a pile gets rerendered here as well - on render they also don't have neither a pile nor a column association & so they're animated in =( no idea how to prevent this without adding specific card attributes when certain interactions start so we can distinguish what kind of behaviour we want here.
    if !@model.get('column')? && !@model.get('pile')
      $(@el).addClass('off-the-board')

  events:
    # the implicit selector is li.m-card' and afaik there's no way to listen only to events on li.m-card[draggable="true"]
    'dragstart': 'handleDragStart'
    'dragenter': 'handleDragEnter'
    'dragover':  'handleDragOver'
    'dragleave': 'handleDragLeave'
    'dragend':   'handleDragEnd'
    'drop':      'handleDrop'
    'dblclick':  'discardToPile'

  # custom function to put some additional meat on 'this' used in the CardsShow template, manually adding the output of certain functions that would otherwise not be accessible from the template (cf.: http://stackoverflow.com/a/10779124 and http://derickbailey.github.com/backbone.marionette/docs/backbone.marionette.html)
  serializeData: ->
    jsonData = @model.toJSON()
    jsonData.humanReadableShort = @model.humanReadableShort()
    jsonData


  setDraggable: =>
    $(@el).attr 'draggable', "#{@model.get 'draggable'}"

  handleDragStart: (event) ->
    return false unless @model.get 'draggable'
    IG.currentlyDraggedCard = @model
    $(@el).addClass 'low-opacity'

  handleDragEnter: (event) ->
    return false unless @isDropTarget()
    $(event.currentTarget).addClass 'is-drop-hovered'

  handleDragOver: (event) ->
    # the following two lines are mandatory for the 'drop' event to fire
    event.preventDefault()
    return false

  handleDragLeave: (event) ->
    $(event.currentTarget).removeClass 'is-drop-hovered'

  handleDragEnd: (event) ->
    $(@el).removeClass 'low-opacity'
    IG.currentlyDraggedCard = undefined

  handleDrop: (event) ->
    event.stopPropagation()
    event.preventDefault()
    return unless @isDropTarget() #@model.isDropTargetFor(IG.currentlyDraggedCard) or $(@el).hasClass('m-card_placeholder')

    if IG.currentlyDraggedCard.get('pile') or IG.currentlyDraggedCard.isLastCardInColumn(IG.currentlyDraggedCard.get('column'))
      IG.currentlyDraggedCard.moveTo @model.get('column')
    else
      cardsToMove = IG.currentlyDraggedCard.get('column').cardsBelow(IG.currentlyDraggedCard)
      cardsToMove.unshift IG.currentlyDraggedCard
      _.each cardsToMove, (card) =>
        card.moveTo @model.get('column')

    $(event.currentTarget).removeClass 'is-drop-hovered'
    IG.currentlyDraggedCard = undefined


  isDropTarget: ->
    # prevent any further action when we're, e.g., dragging a save game file over a card
    return false unless IG.currentlyDraggedCard?
    @model.isDropTargetFor(IG.currentlyDraggedCard) or $(@el).hasClass('m-card_placeholder')

  discardToPile: ->
    return false unless @model.isLastCardInColumn @model.get('column')
    targetPile = @model.isDiscardableTo IG.piles
    if targetPile
      @model.get('column').get('cards').remove @model
      targetPile.get('cards').add @model
