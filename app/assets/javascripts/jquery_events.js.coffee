$ ->
  #$('.m-column .m-card:last-child').attr 'draggable', true

  # $('.columns-wrapper').on 'dragstart', '[draggable="true"]', (event) ->
  #   #event.stopPropagation()
  #   #event.preventDefault()
  #   console.log 'started dragging'
  #   $(@).css 'border', '1px solid red'
  #   console.log event
  #   event.dataTransfer = event.originalEvent.dataTransfer;
  #   #event.dataTransfer.setData("text/plain", "Text to drag")
  #   event.dataTransfer.effectAllowed = 'move'
  #   event.dataTransfer.setData 'text/html', @innerHTML
  #   #return false # required to get rid of ghost drag images
  # $('.columns-wrapper').on 'dragend', '.m-card[draggable="true"]', (event) ->
  #   console.log 'stopped dragging'
  #   $(@).css 'border', '0'
