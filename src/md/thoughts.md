# Angular Alt

- Needed to make a template-service.
- Already got something that will allow us to add modules at will, which is to say that
  we can programmatically add modules.
- Able to plug in Scheming models as an adapter to Rivet.
- Explored rv-each-yyyy and used it to explore common Angular usage.


## Process


## Comparison (Priority 1)

- ng-repeat, ng-if, ng-controller and (service, controller, etc)
- transclusion?

- module life-cycle

- testing?
- routing?


## Ideas (Priority 1)

- Have t3js bind the module to a template auto automatically?
- Add a controller construct, so that something like `[data-module]` can be changed.


## Ideas (Priority 2)

- Could we use Go transpiler instead of Coffee for JS?


## Contribution

```
```


## Limitations (Rivets vs Angular)

- Some of the documentation is out of date, *but* the code is small, readable, and debuggable
- Only have access to key paths, not expressions (yes expressions are harder).
- Some of the built in binders aren't complete (like rv-on-keypress, which doesn't report
  a number of keys like backspace, arrows, etc)
- rv-each inside a rv-each not be possible.  This be a difficult scoping issue
  that would have to be programmed (ng-repeat is probably the most complex directives in
  all of angular).
- rv-each over an associated array is also not possible.  So, at the moment you can only
  loop over arrays.


## Limitations (t3js vs Angular)