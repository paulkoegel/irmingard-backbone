'use strict'

class IG.Models.Card extends Backbone.RelationalModel
  idAttribute: '_id'
  urlRoot: '/cards'
  defaults:
    _id:      null
    deck:     null
    suit:     null
    value:    null
    column:   null
    pile:     null
    stack:    true
    position: null
    open:     false
    backImagePath: '/assets/back.gif'

  initialize: (attributes) ->

  colour: ->
    if (@get('suit') == 'diamonds') or (@get('suit') == 'hearts')
      'red'
    else
      'black'

  humanValue: ->
    switch @get('value')
      when 1
        'ace'
      when 11
        'jack'
      when 12
        'queen'
      when 13
        'king'
      else
        @get('value') + ''

  setSlug: ->
    @set 'slug', "#{@get 'suit'}_#{@humanValue()}_#{@get 'deck'}"

  suitSymbol: ->
    switch @get('suit')
      when 'diamonds'
        '♦'
      when 'hearts'
        '♥'
      when 'spades'
        '♠'
      when'clubs'
        '♣'
      else
        null

  draggable: ->
    @get 'open'

  humanReadable: ->
    "#{@humanValue()}_of_#{@get('suit')}"

  humanReadableShort: ->
    "#{@suitSymbol()}#{@humanValue()}"

  imagePath: ->
    "/assets/#{@humanReadable()}.gif"

  isDropTargetFor: (card) ->
    console.log 'isDroptarget?'
    console.log "values: @ #{@get('value')}, card #{card.get('value')}"
    console.log "colours: @ #{@colour()}, card #{card.colour()}"
    if @get('value') - 1 == card.get('value') and @colour() != card.colour()
      x = true
    else
      x = false
    console.log x
    x
