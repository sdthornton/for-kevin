$(document).on 'page:fetch', ->
  NProgress.start()
.on 'page:change', ->
  NProgress.done()
.on 'page:restore', ->
  NProgress.remove()
