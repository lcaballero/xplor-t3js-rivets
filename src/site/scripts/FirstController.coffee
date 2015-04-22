Box.Application.addModule('first-module', (context) ->
  dc          = context.getService('dc')
  villians    = _.keys(dc.villians())
  characters  = _.keys(dc.heros()).concat(villians)
  newItem     = -> _.sample(characters, 1)
  nextId      = do (id=0) -> -> ++id

  new class Module
    constructor: ->
      @data =
        text    : "stuff"
        names   : [
          { first: newItem(), id: nextId() }
        ]
    init: ->
      rivets.bind(context.getElement(), this)
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



