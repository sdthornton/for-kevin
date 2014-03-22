namespace 'CutTheChi', (exports) ->
  class exports.Haircut extends CutTheChi.BuildModal

    constructor: ->
      @bindShowBid()
      @bindPostBid()
      @bindSearch()
      @loginToBid()
      @showAfterLogin()

    loginToBid: ->
      $('.make-a-bid--login').on 'click', (e) =>
        bidOn = $(e.target).data('bid-on')
        document.cookie = "after_login_show=#{bidOn};path=/"

    showAfterLogin: ->
      if "; #{document.cookie}".indexOf('after_login_show=') > 0
        parts = "; #{document.cookie}".split("; after_login_show=")
        if parts.length == 2
          haircut = parts.pop().split(";").shift()
          url = "/haircuts/#{haircut}"
          @showHaircut(url)

      document.cookie = "after_login_show=;path=/;expires=Thu, 01 Jan 1970 00:00:01 GMT;"

    bindShowBid: ->
      $('.make-a-bid').on 'click.bindBidLink', (e) =>
        e.preventDefault()
        $link = $(e.target)
        url = $link.attr('href')
        @showHaircut(url)

    showHaircut: (url) ->
      $.ajax
        type: 'GET'
        url: url
        dataType: 'json'
      .done (data) =>
        console.log data
        @buildHaircutModal(data)
      .fail (jqXHR, textStatus) =>
        console.log "Request failed: #{textStatus}"

    bindPostBid: ->
      $('body').on 'submit.postBid', "form.place-bid", (e) =>
        e.preventDefault()
        $postBid = $(e.target)

        $.ajax
          type: 'POST'
          url: $postBid.attr('action')
          data: $postBid.serialize()
          dataType: 'json'
        .done (data) =>
          console.log data
          $("##{data.haircut.hash}_haircut").find('.current-bid').text(data.haircut.highest_bid)
          @closeModal()
        .fail (jqXHR, textStatus) =>
          console.log "Request failed: #{textStatus}"

    buildHaircutModal: (data) ->
      has_bids = data.has_bids
      is_admin = data.is_admin
      haircut = data.haircut
      admin = data.admin
      bidForm = $("#place_bid_on_#{haircut.id}_wrap").html()

      haircutHtml = """
        <article class="show-haircut modal" id="show_#{haircut.hash}" data-url="#{haircut.url}">
          <div class="show-haicut__info">
            <img src="#{haircut.photo}" width="364" height="auto">
            <p>#{haircut.name}</p>
          </div>
          <div class="show-haircut__bid-form">
            <p>Current Bid: #{haircut.highest_bid}</p>
            #{bidForm}
          </div>
        </article>
      """

      @buildModal(haircutHtml)

    bindSearch: ->
      searchAnchor = """
        <a href="/haircuts?search=" id="haircut_search_link" class="button">Search</a>
      """

      $('#haircut_search_submit').replaceWith(searchAnchor)

      $('#search_haircuts').on 'submit.searchHaircuts', (e) =>
        e.preventDefault()
        Turbolinks.visit $('#haircut_search_link').attr('href')
      .find('#search').on 'keyup.watchSearchInput', (e) =>
        $('#haircut_search_link').attr 'href', "/haircuts?#{$('#search_haircuts').serialize()}"


