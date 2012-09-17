$ ->
  $('#serve-new-cards').click ->
    console.log 'serve'
    IG.columns.each (column) ->
      console.log 'aa'
      cardToAdd = IG.stack.get('cards').pop(silent: true)
      console.log cardToAdd.humanReadableShort()
      cardToAdd.set {'open': true, 'draggable': true}, silent: true
      column.get('cards').add cardToAdd
