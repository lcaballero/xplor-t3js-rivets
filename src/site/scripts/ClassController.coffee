Box.Application.addModule('first-module', (context) ->
  new class Module
    constructor: ->
      @names = [ { first: "Clark Kent" } ]
      @data =
        words :
          text : "stuff"
        names :
          list : @names
        add : => @names.push({ first: "Bruce Wayne" })
        remove : => @names.pop()
    init: ->
      rivets.bind(context.getElement(), @data)
)


window.onload = ->
  Box.Application.on('error', (ev) -> console.log(ev))
  Box.Application.init({ debug:true });