$ ->
  $('.serve-new-cards').click (event) ->
    event.preventDefault()
    IG.serveNewCards()

  #document.onkeydown=function(e){ if(e.which == 17) isCtrl=true; if(e.which == 83 && isCtrl == true) { //run code for CTRL+S -- ie, save! return false; } if(e.which == 79 && isCtrl == true) { //run code for CTRL+O -- ie, open! return false; } if(e.which == 84 && isCtrl == true) { //run code for CTRL+T -- ie, new tab! return false; } }

  document.onkeydown = (event) ->
    if event.which == 13
      IG.serveNewCards()
      console.log 'pressed enter'

  IG.serveNewCards = () ->
    $button = $('button.serve-new-cards').attr('disabled', 'disabled')
    setTimeout ->
      $button.removeAttr('disabled')
    , 1000
    if IG.stack.get('cards').length
      IG.columns.each (column) ->
        if IG.stack.get('cards').length
          cardToAdd = IG.stack.get('cards').pop(silent: true)
          cardToAdd.set {'open': true, 'draggable': true}, silent: true
          column.get('cards').add cardToAdd
    $('.stack-counter').text "(#{IG.stack.get('cards').length})"

  # - START super redundant code (copied from CardsShow) - - -
  $('.m-card_placeholder').on 'dragenter', (event) ->
    if IG.currentlyDraggedCard.humanValue() == 'king'
      $(@).addClass('is-drop-hovered')

  $('.m-card_placeholder').on 'dragleave', (event) ->
    $(@).removeClass 'is-drop-hovered'

  $('.m-card_placeholder').on 'dragover', (event) ->
    # the following two lines are mandatory for the 'drop' event to fire
    event.preventDefault()
    return false

  $('.m-card_placeholder').on 'drop', (event) ->
    event.stopPropagation()
    event.preventDefault()
    return unless IG.currentlyDraggedCard.humanValue() == 'king'
    columnIndex = $(@).data('column-index')
    column = IG.columns.at(columnIndex)
    if IG.currentlyDraggedCard.isLastCardInColumn(IG.currentlyDraggedCard.get('column'))
      IG.currentlyDraggedCard.moveTo column
    else
      cardsToMove = IG.currentlyDraggedCard.get('column').cardsBelow(IG.currentlyDraggedCard)
      cardsToMove.unshift IG.currentlyDraggedCard
      _.each cardsToMove, (card) =>
        card.moveTo column
    $(@).removeClass 'is-drop-hovered'
    IG.currentlyDraggedCard = undefined
  # - END super redundant code (copied from CardsShow) - - -
