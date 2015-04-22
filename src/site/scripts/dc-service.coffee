Box.Application.addService('dc', (application) ->
  heroes = {
    "Clark Kent"        : "Superman"
    "Barry Allen"       : "The Flash"
    "Hal Jordan"        : "Green Lantern"
    "Richard Justice"   : "Cyborg"
    "Arthur Curry"      : "Aquaman"
    "Diana"             : "Wonder Woman"
    "Selina Kyle"       : "Catwoman"
    "Billy Batson"      : "Captain Marvel"
    "J'onn J'onzz"      : "Martian Manhunter"
  }
  villians = {
    "Lex Luther"        : "Lex"
    "Leonard Snart"     : "Captain Cold"
    "Edward Nigma"      : "Ridler"
  }
  characters = _.keys(heroes).concat(_.keys(villians))

  new class Dc
    constructor : ->
    villians    : -> villians
    heros       : -> heroes
    characters  : -> characters
)

