Box.Application.addService('config-service', ->
  field = (args...) ->
    [containerName, containerDisplay, fieldName, fieldDisplay, type] = args
    { containerName, containerDisplay, fieldName, fieldDisplay, type }


  new class ConfigService
    getFields: =>
      messages =
        link :
          name : 'LinkConfigMessage'
          display : 'Link Config'
        columboClient :
          name : 'ColumboClientConfigMessage'
          display: 'Columbo Client Config'
        columbo :
          name : 'ColumboConfigMessage'
          display: 'Columbo Config'
        configServer :
          name : 'ConfigServerMessage'
          display: 'Config Server'

      [
        field(messages.link.name, messages.link.display, "minutesToRest", "Minutes to Rest", Number)
        field(messages.link.name, messages.link.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columboClient.name, messages.columboClient.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columboClient.name, messages.columboClient.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columbo.name, messages.columbo.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columbo.name, messages.columbo.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.configServer.name, messages.configServer.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.configServer.name, messages.configServer.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)

        field(messages.link.name, messages.link.display, "minutesToRest", "Minutes to Rest", Number)
        field(messages.link.name, messages.link.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columboClient.name, messages.columboClient.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columboClient.name, messages.columboClient.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columbo.name, messages.columbo.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.columbo.name, messages.columbo.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.configServer.name, messages.configServer.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
        field(messages.configServer.name, messages.configServer.display, "searchThreadPoolSize", "Search Thread Pool Size", Number)
      ]

    getFieldGroups: =>
      fields = @getFields()
      groups = {}
      for f in fields
        if !groups[f.containerName]?
          groups[f.containerName] = []
        groups[f.containerName].push(f)
      groups

      for group,fields of groups
        { name: group, fields: fields }

    getContainers: =>
      _(@getFields())
      .pluck('containerName')
      .uniq()
      .value()
)