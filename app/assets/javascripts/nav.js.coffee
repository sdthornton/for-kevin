namespace 'CutTheChi', (exports) ->
  class exports.Nav

    constructor: ->
      @$open  = $('#open_menu')
      @$close = $('#close_menu')
      @$menu  = $('#site_menu')
      @bindMenuLinks()

    bindMenuLinks: ->
      @$open.on 'click', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$menu.removeClass('closed').addClass('open')

      @$close.on 'click', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$menu.removeClass('open').addClass('closed')
