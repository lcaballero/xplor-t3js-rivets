window.onload = ->

  $('#new-module').on("click", (ev) ->
    console.log("click", ev)
    el = $("[data-module='first-module']:first")
    name = el.attr("data-module")
    tpl = Box.Application.getService('template-service').get(name)
    c = $(tpl).clone()[0]

    $(document.body).append(c)
    Box.Application.start(c)
  )

  Box.Application.on('error', (ev) -> console.log(ev))
  Box.Application.init({ debug:true });

