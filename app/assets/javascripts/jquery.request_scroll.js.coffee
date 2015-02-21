# Works on IE9+

jQuery.requestScroll = (callback) ->
  data = window.scrollRequestsData ||= {}
  requests = data.requests ||= {}

  # Ideally, using multiple instances prevents conflicts between ticking
  # It also allows for an easy way to remove the specific scroll event
  # This performance is still being investigated
  scrollInstanceNum = Object.keys(requests).length + 1
  inst = requests['request_' + scrollInstanceNum] = {}

  if data.lastScrollY? then lastScrollSet = true else data.lastScrollY = 0
  inst.ticking = false

  inst.onScroll = ->
    data.lastScrollY = window.pageYOffset unless lastScrollSet
    requestTick()

  requestTick = ->
    unless inst.ticking
      window.requestAnimationFrame(inst.update)
      inst.ticking = true

  inst.update = ->
    callback(data.lastScrollY)
    inst.ticking = false

  # Sets window.requestAnimationFrame if not already set
  do ->
    lastTime = 0
    vendors = ['ms', 'moz', 'webkit', 'o']
    for vendor in vendors when !window.requestAnimationFrame
      window.requestAnimationFrame =
        window[vendor+'RequestAnimationFrame'];
      window.cancelAnimationFrame =
        window[vendor+'CancelAnimationFrame'] ||
        window[vendor+'CancelRequestAnimationFrame']

    unless window.requestAnimationFrame
      window.requestAnimationFrame = (callback, element) ->
        currTime = new Date().getTime()
        timeToCall = Math.max(0, 16 - (currTime - lastTime))
        id = window.setTimeout(->
          callback(currTime + timeToCall)
        , timeToCall)
        lastTime = currTime + timeToCall
        return id

    unless window.cancelAnimationFrame
      window.cancelAnimationFrame = (id) ->
        clearTimeout(id)

  window.addEventListener('scroll', inst.onScroll, false)
  return inst

# To cancel a requestScroll, first set the $.requestScroll to a variable
# then pass in that variable to $.cancelRequestScroll
$.cancelRequestScroll = (requestScrollInst) ->
  window.removeEventListener('scroll', requestScrollInst.onScroll, false)
  window.cancelAnimationFrame(requestScrollInst.update)
