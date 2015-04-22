Box.Application.addModule('first-module', (context) ->
  init: ->
    Words = Scheming.create "Words",
      text:
        type: String

    names = [
      { first: "Clark Kent" }
    ]
    data =
      words :
        text : "stuff"
      names :
        list : names
      add :
        name : -> names.push({ first: "Bruce Wayne" })
      remove :
        name : -> names.pop()

    rivets.bind(context.getElement(), data)
)

Box.Application.on('error', (ev) -> console.log(ev))
window.onload = ->
#  rivets.adapters['.'] =
#    observe: (obj, keypath, callback) ->
#      if obj?.watch?
#        obj.watch(keypath, callback)
#    unobserve: (obj, keypath, callback) ->
#    get: (obj, keypath) -> obj[keypath]
#    set: (obj, keypath, value) -> obj[keypath] = value

  Box.Application.init({ debug:true });