namespace 'CutTheChi', (exports) ->
  class exports.Nav

    constructor: ->
      @$open      = $('#open_menu')
      @$close     = $('#close_menu')
      @$menu      = $('#site_menu')
      @$user      = $('#show_user_links')
      @$userNav   = $('#user_nav')
      @$userArrow = @$user.find('.icon--right')
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

      @$user.on 'click.showUserLinks', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @toggleUserLinks()

        $('body').not('#user_nav').on 'click.closeUserLinks', (e) =>
          @closeUserLinks()
          $('body').off('.closeUserLinks')

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

    toggleUserLinks: ->
      if @$userNav.hasClass('open')
        @closeUserLinks()
      else
        @openUserLinks()

    closeUserLinks: ->
      @$userNav[0].classList.remove('open')
      @$userArrow[0].classList.remove('ion-arrow-up-b')
      @$userArrow[0].classList.add('ion-arrow-down-b')

    openUserLinks: ->
      @$userNav[0].classList.add('open')
      @$userArrow[0].classList.add('ion-arrow-up-b')
      @$userArrow[0].classList.remove('ion-arrow-down-b')
