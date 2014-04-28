namespace 'CutTheChi', (exports) ->
  class exports.CloseVenueNotice

    constructor: ->
      @closeVenueNotice()

    closeVenueNotice: ->
      $('#close_venue_change').on 'click', (e) =>
        e.preventDefault()
        url = $(e.target).attr('data-post-href')
        $.ajax
          type: 'POST'
          url: url
        .done =>
          $('#venue_change').remove()
          $('body').removeClass('venue-notice')
        .fail (a, b) =>
          console.log a
          console.log b
