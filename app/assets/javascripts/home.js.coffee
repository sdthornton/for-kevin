namespace 'CutTheChi', (exports) ->
  class exports.Home

    constructor: ->
      @bindLoginToBid()

    bindLoginToBid: ->
      $('.make-a-bid--login').on 'click', (e) =>
        bidOn = $(e.target).data('bid-on')
        document.cookie = "show_haircut=#{bidOn};path=/"
