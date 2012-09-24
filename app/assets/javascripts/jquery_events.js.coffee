$ ->
  $('#serve-new-cards').click (event) ->
    event.preventDefault()
    $button = $(event.currentTarget).attr('disabled', 'disabled')
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


  # hacky alternative to DOMNodeInserted, cf.: http://davidwalsh.name/detect-node-insertion
  insertListener = (event) ->
    if event.animationName == 'nodeInserted'
      $(event.target).css('top', '0')

  # insertListener() MUST be declared before these
  document.addEventListener('animationstart', insertListener, false) # standard + Firefox
  document.addEventListener('webkitAnimationStart', insertListener, false) # Chrome + Safari
  document.addEventListener('MSAnimationStart', insertListener, false) # IE
