Box.Application.addService('config-service', ->
  new class ConfigService
    getFields: =>
      [
        { container: "LinkConfigMessage", name: "minutesToRest", display: "Minutes to Rest", type: Number }
        { container: "LinkConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }

        { container: "ColumboClientConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }
        { container: "ColumboClientConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }

        { container: "ColumboConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }
        { container: "ColumboConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }

        { container: "ConfigServerConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }
        { container: "ConfigServerConfigMessage", name: "searchThreadPoolSize", display: "Search Thread Pool Size", type: Number }
      ]
    getFieldGroups: =>
      fields = @getFields()
      groups = {}
      for f in fields
        if !groups[f.container]?
          groups[f.container] = []
        groups[f.container].push(f)
      groups

      for group,fields of groups
        { name: group, fields: fields }

    getContainers: =>
      _(@getFields())
        .pluck('container')
        .uniq()
        .value()
)

Box.Application.addService('validate-service', ->
  new class ValidateService
    getValidation: (container, field, value) =>
)

Box.Application.addService('', ->)

Box.Application.addModule('config-ctrl', (context) ->
  new class Module
    constructor: ->
    init: ->
      svc = context.getService('config-service')


      @groups = _.keys(svc.getFieldGroups())
      @fields = svc.getFields()
      @containers = svc.getContainers()
      rivets.bind(context.getElement(), this)
    keypress: (ev, {field}) =>
      console.log('keypress', field.container, field.name, ev.currentTarget.value)
)


