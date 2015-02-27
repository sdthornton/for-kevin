namespace 'CutTheChi', (exports) ->
  class exports.BiddingInfo

    constructor: ->
      @$biddingInfo = $('.bidding-info')
      @getBiddingInfo()

    getBiddingInfo: ->
      _this = @
      request = new XMLHttpRequest()
      request.open('GET', '/bid_info', true)
      request.onload = ->
        if @status >= 200 && @status <= 400
          response = JSON.parse(@response)
          _this.populateTotalRaised(response.total_raised)
          _this.populateTimeLeft(response.time_left)
          _this.populateTotalBids(response.unique_bids)
        else
          console.log 'Successfully reached server but some error occurred'
      request.onerror = ->
        console.log 'Error reaching server'
      request.send()

    populateTotalRaised: (totalRaised) ->
      @$biddingInfo.find('.bidding-total__text').text(totalRaised)

    populateTimeLeft: (timeLeft) ->
      @$biddingInfo.find('.time-left--days').text(timeLeft.days)
      @$biddingInfo.find('.time-left--hours').text(timeLeft.hours)
      @$biddingInfo.find('.time-left--minutes').text(timeLeft.minutes)

    populateTotalBids: (totalBids) ->
      @$biddingInfo.find('.bidding-count__text').text(totalBids)
