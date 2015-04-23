Box.Application.addService('template-service', (application) ->
  new class TemplateService
    constructor: ->
      @modules = {}
    add: (name, el) => @modules[name] = el
    get: (name) => @modules[name]
)