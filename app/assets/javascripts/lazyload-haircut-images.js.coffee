namespace 'CutTheChi', (exports) ->
  class exports.LazyLoadHaircutImages
    constructor: ->
      $('.haircut-image').each(@loadImage)

    loadImage: (i, image) =>
      $image = $(image)
      path = $image.data('src')
      if @isRetina()
        path = path.replace('/normal/', '/retina/')

      newImage = new Image
      newImage.onload = ->
        image.src = @src
      newImage.src = path;

    isRetina: ->
      document.cookie.indexOf('is_retina=true') > -1
