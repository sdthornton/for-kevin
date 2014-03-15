# Creates a namespaced class or method

# Example usages:
# namespace 'Foo.Bar', (exports) ->
#   class export.Baz
#     ...
# namespace 'Foo.Baz', (exports) ->
#  exports.alertFoo = ->
#    alert 'foo'

window.namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top


# Create delayAddClass function
(($) ->
  $.fn.delayAddClass = (className, timing) ->
    setTimeout =>
      this.addClass(className)
    , timing
    return this
  return
)(jQuery)


# Create delayRemove function
(($) ->
  $.fn.delayRemove = (timing) ->
    setTimeout =>
      this.remove()
    , timing
    return this
  return
)(jQuery)
