$ ->
  $('.serve-new-cards').click (event) ->
    event.preventDefault()
    IG.serveNewCards()

  # serve new cards on pressing 'Enter'
  document.onkeydown = (event) ->
    if event.which == 13
      IG.serveNewCards()

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

  # DROPPING ON PLACEHOLDERS
  # - START super redundant code (copied from CardsShow) - - -
  $('#l-game-container').on 'dragenter', '.m-column .m-card_placeholder', (event) ->
    if IG.currentlyDraggedCard.humanValue() == 'king'
      $(@).addClass('is-drop-hovered')

  $('#l-game-container').on 'dragleave', '.m-column .m-card_placeholder', (event) ->
    $(@).removeClass 'is-drop-hovered'

  $('#l-game-container').on 'dragover', '.m-column .m-card_placeholder', (event) ->
    # the following two lines are mandatory for the 'drop' event to fire
    event.preventDefault()
    return false

  $('#l-game-container').on 'drop', '.m-column .m-card_placeholder', (event) ->
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

  IG.gameWon = $('body').pinkify
  IG.gameWonParameters=
    imageUrl:    '/assets/at-at.gif'
    imageWidth:  140
    imageHeight: 104
    animation:
      direction: 'left'
      duration:  3
    audioFiles: [
      '/assets/imperial_march_of_the_floppies.ogg',
      '/assets/imperial_march_of_the_floppies.mp3'
    ]
    audioAttr:
      autoplay: 'autoplay'
      loop: true
    click: ->
    #  $(@).pinkify('destroy')
    aAttr:
      href: 'http://www.youtube.com/watch?v=qWkUFxItWmU',
      target: '_blank'
