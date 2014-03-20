namespace 'CutTheChi', (exports) ->
  class exports.FasterPainting

    constructor: ->
      @enableTimer = 0
      @bindScroll()

    bindScroll: ->
      window.addEventListener 'scroll', =>
        clearTimeout(@enableTimer)
        @removeHoverClass()
        @enableTimer = setTimeout(@addHoverClass, 250)
      , false

    removeHoverClass: ->
      document.body.classList.remove('hover')

    addHoverClass: ->
      document.body.classList.add('hover')
