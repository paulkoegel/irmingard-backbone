if !@console
  window.console =
    log: ->

# can't use jQuery here since this file's loaded before application.coffee
# if document.readyState == 'complete'
# for some reason the above never triggers, reverting to a plain alert - which is triggered twice, for some reason. Only affects IE, so what...
alert "Hello there, it seems you're on some prelapsarian version of Internet Explorer.\n
Unfortunately, this game was built with modern browsers in mind.\n
Expect things to break - sorry!\n\n
Hallo, leider ist ihre Internet Explorer Version zu alt für dieses Spiel."
