namespace 'CutTheChi', (exports) ->
  class exports.BuildModal

    buildModal: (modalContent) ->
      closingTag = modalContent.lastIndexOf('</')
      contentStart = modalContent.substr(0, closingTag)
      contentClose = modalContent.substr(closingTag, modalContent.length)

      modal = """
        <div class="modal-wrapper">
          <div class="modal-background">
            #{contentStart}
              <a href="javascript:void(0)" class="close-modal">&times;</a>
            #{contentClose}
          </div>
        </div>
      """

      $('.modal-wrapper').remove()
      $('body').append(modal)
      $('.modal-wrapper').delayAddClass('fade-in', 1)
      @bindCloseModal()

    bindCloseModal: ->
      $modal = $('.modal-wrapper')

      $modal.on 'click.closeModal', '.modal-background', (e) =>
        if e.target == e.currentTarget || e.target.className == 'close-modal'
          @closeModal()

      $(document).on 'keydown.closeModal', (e) =>
        if e.keyCode == 27
          @closeModal()

    closeModal: ->
      $('.modal-wrapper').removeClass('fade-in').addClass('fade-out').delayRemove(500)
      $(document).off('.closeModal')
      $('.modal-wrapper').off('.closeModal')
