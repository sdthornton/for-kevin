namespace 'CutTheChi', (exports) ->
  class exports.NewHaircut

    constructor: ->
      @photoWrap    = document.getElementById('photo_preview')
      @photoWarning = document.getElementById('photo_preview_warning')
      @bindPhotoUpload()

    bindPhotoUpload: ->
      document.getElementById('haircut_photo')
        .addEventListener('change', @handleFileSelect, false)

    handleFileSelect: (e) =>
      file = e.target.files[0]

      @photoWrap.innerHTML = ""
      @photoWrap.style.display = "none"
      @photoWarning.style.display = "none"

      if (!!file and file.type.match('image.*'))
        @showPhotoPreview(file, e)

    showPhotoPreview: (file, e) =>
      reader = new FileReader()
      reader.onload = ((file)=>
        return (e) =>
          img = document.createElement('img')
          img.src = e.target.result
          img.className = "photo-preview-img"
          img.id = "photo_preview_img"
          @photoWrap.insertBefore(img, null)
          @photoWrap.style.display = "block"
          @photoWarning.style.display = "block"
      )(file)

      reader.readAsDataURL(file)
