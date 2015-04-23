Box.Application.addService('tab-set.template', ->
  alter = (elem) ->
    tab = elem.find('tab').detach()
    tab.attr("rv-each-tab", "tabs")
    tab.attr("rv-on-click", "activate")
    tab.attr("rv-class-active", "tab.active")

    content = elem.find('tab-content').detach()
    content.attr("rv-each-tab", "tabs")
    content.find('div').attr('rv-if', 'tab.active')

    nav     = $("<nav/>")
    section = $("<section/>")

    nav.append(tab)
    section.append(content)

    elem.append(nav)
    elem.append(section)

  new class TabSetTemplate
    templatize: (context) ->
      elem = $(context.getElement());
      el = elem.clone().removeAttr("id")

      newTemplate = alter(el)
      elem.replaceWith(el)
      context.element = el;
      context.getService('template-service').add('tab-set', newTemplate)
)
Box.Application.addService('tab-set.tab-model', ->
  class TabModel
    constructor: (tabs, active) ->
      @hash = {}
      for t in tabs
        t.active = t.id is active
        @hash[t.id] = t
    clear: ->
      for k,v of @hash
        v.active = false
    activate: (id) ->
      @clear()
      @hash[id].active = true
    isActive: (id) -> @hash[id].active
)
Box.Application.addModule('tab-set', (ctx) ->

  ctx.getService('tab-set.template').templatize(ctx)
  TabModel = ctx.getService('tab-set.tab-model')

  new class TabSet
    constructor: ->
      @tabs =
        for n in [1..4]
          {name:"Tab-#{n}", id:"id-#{n}", content: "content-#{n}"}
      @tabs[0].active = true

    init: =>
      el = ctx.getElement()
      @model = new TabModel(@tabs, $(el).attr("active"))
      rivets.bind(ctx.getElement(), this)

    activate: (ev, binding) =>
      @model.activate(binding.tab.id)
)


