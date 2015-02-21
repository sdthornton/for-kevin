namespace 'CutTheChi', (exports) ->
  class exports.FasterPainting

    constructor: ->
      @enableTimer = 0
      @bindScroll()

    bindScroll: ->
      $.requestScroll(@toggleHoverClass)

    toggleHoverClass: =>
      clearTimeout(@enableTimer)
      @removeHoverClass()
      @enableTimer = setTimeout(@addHoverClass, 250)

    removeHoverClass: ->
      document.body.classList.remove('hover')

    addHoverClass: ->
      document.body.classList.add('hover')
