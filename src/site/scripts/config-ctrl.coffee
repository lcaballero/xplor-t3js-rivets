Box.Application.addService('config-ctrl.group.template', ->
  class GroupTemplate
    constructor: (context, selector) ->
      @group = $(context.getElement()).find(selector)
      @parent = @group.parent()
      @group = @group.detach().clone()

    append: (data) ->
      template = @group.clone()
      @parent.append(template)
      rivets.bind(template, data)
)

Box.Application.addModule('config-ctrl', (context) ->
  GroupTemplate = context.getService('config-ctrl.group.template')
  Groups  = new GroupTemplate(context, "div.group")

  new class Module
    constructor: ->
    init: ->
      elem        = context.getElement()
      svc         = context.getService('config-service')
      @containers = svc.getContainers()
      @groups     = svc.getFieldGroups()

      rivets.bind(elem, this)

      for group in @groups
        group.keypress = @keypress
        Groups.append(group)

    keypress: (ev, {field}) =>
      console.log(
        'keypress', field.container,
        field.name, ev.currentTarget.value)
)


