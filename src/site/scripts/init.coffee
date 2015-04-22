window.onload = ->
  Box.Application.on('error', (ev) -> console.log(ev))
  Box.Application.init({ debug:true });