#= require build_modal

namespace 'CutTheChi', (exports) ->
  class exports.Haircut

    constructor: (@page) ->
      @modal = new CutTheChi.BuildModal(@pushCloseState)
      @showBidNoticeIfFresh()
      @showFromRoute()
      @bindShowBid()
      @bindPostBid()
      @bindSearch()

    showBidNoticeIfFresh: ->
      if !!window.CutTheChi.freshBid
        document.querySelector('.successful-bid').classList.remove('hidden')

    showFromRoute: ->
      pathname = window.location.pathname
      if pathname.match(/\/haircuts\/(?!(page|search|filter)).+/)
        haircut = pathname.replace('/haircuts/', '')
        @showHaircut(pathname, haircut, false)

    bindShowBid: ->
      $('.open-haircut').on 'click.bindBidLink', (e) =>
        e.preventDefault()
        $link = $(e.currentTarget)
        url = $link.attr('href')
        haircut = url.replace('/haircuts/', '')
        @showHaircut(url, haircut)

    showHaircut: (url, haircut, update = true) ->
      $.ajax
        type: 'GET'
        url: url
        dataType: 'json'
      .done (data) =>
        if !!data.logged_in
          @buildHaircutModal(data)
          @pushHaircutState(url, haircut) if update
      .fail (jqXHR, textStatus) =>
        console.log "Request failed: #{textStatus}"

    pushHaircutState: (url, haircut) ->
      fullURL = "#{window.location.origin}#{url}"
      window.history.pushState({ turbolinks: true, url: fullURL, haircut: haircut }, haircut, url);

    pushCloseState: =>
      page = if @page then "page/#{@page}" else ""
      url = window.location.pathname.replace(/\/haircuts\/.+/gi, "/haircuts/#{page}")
      fullURL = "#{window.location.origin}#{url}"
      window.history.pushState({ turbolinks: true, url: fullURL }, '', url)

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
            # @$successfulBidAmount.text(data.haircut.highest_bid)
            # @$successfulBidName.text(data.haircut.name)
            # $("##{data.haircut.hash}_haircut")
            #   .find('.haircut-item__current-bid')
            #   .text("Top Bid: #{data.haircut.highest_bid}")
            # @modal.closeModal()
            # @$successfulBidInput.prop('checked', false)
            # @$successfulBid.removeClass('hidden')
            page = if @page then "page/#{@page}" else ""
            url = "/haircuts/#{page}"
            window.CutTheChi.freshBid = true
            Turbolinks.visit(url)
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
      @modal.buildModal(haircutHtml)

    bindSearch: ->
      $searchHaircuts = $('#search_haircuts')
      $queryInput = $searchHaircuts.find('#query')
      $querySubmit = $searchHaircuts.find('#haircut_search_submit')

      $queryInput.on 'keyup.searchHaircuts', (e) ->
        if e.keyCode == 13
          Turbolinks.visit($querySubmit.attr('href'))
        else
          $querySubmit.attr('href', "/haircuts/search/#{e.target.value}")

      $querySubmit.on 'click.searchHaircuts', ->
        Turbolinks.visit($querySubmit.attr('href'))
