namespace 'CutTheChi', (exports) ->
  class exports.EditHaircut

    constructor: ->
      @$currentPhoto = $('.current-photo')
      @$cropPhoto    = $('.crop-photo')
      @$newPhoto     = $('.upload-haircut-image')
      @$editNew      = $('.edit-photo__new')
      @$editCrop     = $('.edit-photo__crop')
      @$editCancel   = $('.edit-photo__cancel')
      @$photoLabel   = $('.photo-label')
      @$photoCrops   = $('#photo_crop_x, #photo_crop_y, #photo_crop_w, #photo_crop_h')
      @bindLinks()
      @disablePhotoCrop()

    bindLinks: ->
      @$editNew.on 'click.newPhoto', @uploadNewPhoto
      @$editCrop.on 'click.editPhoto', @cropPhoto
      @$editCancel.on 'click.useCurrentPhoto', @useCurrentPhoto

    disablePhotoCrop: ->
      @$photoCrops.attr('disabled', 'disabled')

    enablePhotoCrop: ->
      @$photoCrops.removeAttr('disabled')

    uploadNewPhoto: (e) =>
      e.preventDefault()
      @disablePhotoCrop()
      @$currentPhoto.hide()
      @$newPhoto.show()
      @$cropPhoto.hide()
      @$editNew.hide()
      @$editCrop.show()
      @$editCancel.show()
      @$photoLabel.hide()

    cropPhoto: (e) =>
      e.preventDefault()
      @enablePhotoCrop()
      @$currentPhoto.hide()
      @$newPhoto.hide()
      @$cropPhoto.show()
      @$editNew.show()
      @$editCrop.hide()
      @$editCancel.show()
      @$photoLabel.show()

    useCurrentPhoto: (e) =>
      e.preventDefault()
      @disablePhotoCrop()
      @$currentPhoto.show()
      @$newPhoto.hide()
      @$cropPhoto.hide()
      @$editNew.show()
      @$editCrop.show()
      @$editCancel.hide()
      @$photoLabel.show()
