$ ->
  $('#serve-new-cards').click ->
    console.log 'serve'
    IG.columns.each (column) ->
      console.log 'aa'
      cardToAdd = IG.stack.get('cards').pop(silent: true)
      console.log cardToAdd.humanReadableShort()
      cardToAdd.set {'open': true, 'draggable': true}, silent: true
      column.get('cards').add cardToAdd

  $('.m-card_placeholder').on 'dragenter', (event) ->
    console.log 'dragEnter on placholder!!'
    if IG.currentlyDraggedCard.humanValue() == 'king'
      console.log 'kings welcome!'
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
    console.log 'DROPPED from da jquery events'
    columnIndex = $(@).data('column-index')
    column = IG.columns.at(columnIndex)
    console.log column.get('_id')
    if IG.currentlyDraggedCard.isLastCardInColumn(IG.currentlyDraggedCard.get('column'))
      IG.currentlyDraggedCard.moveTo column
    else
      cardsToMove = IG.currentlyDraggedCard.get('column').cardsBelow(IG.currentlyDraggedCard)
      cardsToMove.unshift IG.currentlyDraggedCard
      _.each cardsToMove, (card) =>
        card.moveTo column
    $(@).removeClass 'is-drop-hovered'
    IG.currentlyDraggedCard = undefined
