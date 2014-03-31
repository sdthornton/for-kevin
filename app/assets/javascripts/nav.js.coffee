namespace 'CutTheChi', (exports) ->
  class exports.Nav

    constructor: ->
      @$open  = $('#open_menu')
      @$close = $('#close_menu')
      @$menu  = $('#site_menu')
      @bindMenuLinks()

    bindMenuLinks: ->
      @$open.on 'click.openMenu', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @openMenu()

      @$close.on 'click.closeMenu', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @closeMenu()

    bindEscKey: ->
      $(window).on 'keyup.closeMenu', (e) =>
        e.stopPropagation()
        if e.keyCode == 27
          @closeMenu()

    closeMenu: ->
      @$menu.removeClass('open').addClass('closed')
      $(window).off('.closeMenu')

    openMenu: ->
      @$menu.removeClass('closed').addClass('open')
      @bindEscKey()
