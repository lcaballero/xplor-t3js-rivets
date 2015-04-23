Box.Application.addModule('left-panel', (context) ->
  new class LeftPanel
    init: =>
      @color = "#00ff00"
      @open = false
      rivets.bind(context.getElement(), this)
    toggle: =>
      console.log(@open)
      @open = !@open
      console.log(@open)
)

Box.Application.addModule('first-module', (context) ->

  template = $(context.getElement()).clone().removeAttr("id")
  context.getService('template-service').add('first-module', template)

  dc          = context.getService('dc')
  villians    = _.keys(dc.villians())
  characters  = _.keys(dc.heros()).concat(villians)
  newItem     = -> _.sample(characters, 1)
  nextId      = do (id=0) -> -> ++id

  new class Module
    messages : ['require-names']
    constructor: ->
      @data =
        text    : "stuff"
        names   : [
          { first: newItem(), id: nextId() }
        ]
    init: ->
      rivets.bind(context.getElement(), this)
    onmessage: (name, cb) ->
      console.log(name, cb(@data.names))
    add     : =>
      id = nextId()
      @data.names.push(
        first : newItem()
        id    : id
      )
    remove  : (ev) =>
      id  = $(ev.currentTarget).attr("item-id")
      n   = _.findIndex(@data.names, (d) -> d.id is parseInt(id))
      if n >= 0
        @data.names.splice(n,1)
)


