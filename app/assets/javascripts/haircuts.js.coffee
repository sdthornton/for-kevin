namespace 'Site', (exports) ->
  class exports.Haircut

    constructor: ->
      @bindBidLinks()

    bindBidLinks: ->
      $('.make-a-bid').on 'click.bindBidLink', (e) =>
        e.preventDefault()

        $link = $(e.target)
        url = $link.attr('href')

        $.ajax
          type: 'GET'
          url: url
          dataType: "json"
        .done (data) =>
          console.log data
          @showHaircut(data)
        .fail (jqXHR, textStatus) =>
          console.log "Request failed: #{textStatus}"

    showHaircut: (data) ->
      has_bids = data.has_bids
      is_admin = data.is_admin
      haircut = data.haircut
      admin = data.admin

      haircut = """
      <div class="modal-wrapper">
        <div class="modal-background">
          <article class="show-haircut modal" id="show_#{haircut.hash}" data-url="#{haircut.url}">
            <img src="#{haircut.photo}" width="364" height="auto">
            #{haircut.name}
          </article>
        </div>
      </div>
      """

      $('.show-haircut').remove()
      $('body').append(haircut)

      $('.modal-wrapper').delayAddClass('fade-in', 1)

      $(document).on 'keydown.closeModal', (e) =>
        if e.keyCode == 27
          $('.modal-wrapper').removeClass('fade-in').addClass('fade-out').delayRemove(500)
