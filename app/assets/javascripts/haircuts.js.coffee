namespace 'CutTheChi', (exports) ->
  class exports.Haircut extends CutTheChi.BuildModal

    constructor: ->
      @bindShowBid()
      @bindPostBid()
      @bindSearch()
      @showAfterLogin()

    showAfterLogin: ->
      if "; #{document.cookie}".indexOf('show_haircut=') > 0
        parts = "; #{document.cookie}".split("; show_haircut=")
        if parts.length == 2
          haircut = parts.pop().split(";").shift()
          url = "/haircuts/#{haircut}"
          @showHaircut(url)

      document.cookie = "show_haircut=;path=/;expires=Thu, 01 Jan 1970 00:00:01 GMT;"

    bindShowBid: ->
      $('.make-a-bid').on 'click.bindBidLink', (e) =>
        e.preventDefault()
        $link = $(e.currentTarget)
        url = $link.attr('href')
        @showHaircut(url)

    showHaircut: (url) ->
      $.ajax
        type: 'GET'
        url: url
        dataType: 'json'
      .done (data) =>
        if !!data.logged_in
          @buildHaircutModal(data)
      .fail (jqXHR, textStatus) =>
        alert "Request failed: #{textStatus}"

    bindPostBid: ->
      $('body').on 'submit.postBid', "form.place-bid", (e) =>
        e.preventDefault()
        $postBid = $(e.currentTarget)

        $.ajax
          type: 'POST'
          url: $postBid.attr('action')
          data: $postBid.serialize()
          dataType: 'json'
        .done (data) =>
          if !!data.bid_errors
            bidErrors    = data.bid_errors
            $bidErrorDiv = $('body').find(".bid-errors__#{data.haircut.hash}")
            $bidErrorDiv.html('').show()
            for error in bidErrors
              $bidErrorDiv.append("<div class='bid-error'>Bid #{error}</div>")
          else
            Turbolinks.visit "#{window.location.pathname}#haircuts"
        .fail (jqXHR, textStatus) =>
          alert "Request failed: #{textStatus}"

    buildHaircutModal: (data) ->
      has_bids = data.has_bids
      is_admin = data.is_admin
      haircut = data.haircut
      admin = data.admin
      bidForm = $("#place_bid_on_#{haircut.id}_wrap").html()

      haircutHtml = """
        <article class="show-haircut modal" id="show_#{haircut.hash}" data-url="#{haircut.url}">
          <div class="show-haircut__info">
            <img src="#{haircut.photo}" width="364" height="243" class="show-haircut__img">
            <div class="show-haircut__name"><strong>#{haircut.name}</strong></div>
          </div>
          <div class="show-haircut__bid-form">
            <p class="show-haircut__current-bid"><strong>Current Bid: #{haircut.highest_bid}</strong></p>
            #{bidForm}
          </div>
        </article>
      """

      @buildModal(haircutHtml)

    bindSearch: ->
      searchAnchor = """
        <a href="/haircuts?search=" id="haircut_search_link" class="button search-button">Search</a>
      """

      $('#haircut_search_submit').replaceWith(searchAnchor)

      $('#search_haircuts').on 'submit.searchHaircuts', (e) =>
        e.preventDefault()
        Turbolinks.visit $('#haircut_search_link').attr('href')
      .find('#search').on 'keyup.watchSearchInput', (e) =>
        $('#haircut_search_link').attr 'href', "/haircuts?#{$('#search_haircuts').serialize()}"


