namespace 'CutTheChi', (exports) ->
  class exports.BetterPlaceholders

    constructor: ->
      @bindInputs()

    bindInputs: ->
      $('body').on 'focus.createBetterPlaceholders', '.text-input', (e) =>
        $input = $(e.target)
        unless $input.hasClass('has-better-placeholder')
          $input[0].classList.add('has-better-placeholder')
          placeholderVal = $input.attr('placeholder')
          if placeholderVal == "Password Confirmation" then placeholderVal = "Confirm"
          $wrap = $input.parent('.input')
          inputVal = $input.val()

          betterPlaceholderHTML = """
            <span class="better-placeholder hidden">#{placeholderVal}</span>
          """

          $betterPlaceholder = $(betterPlaceholderHTML)
          $wrap.append($betterPlaceholder)

          originalRightPadding = parseInt($input.css('padding-right'), 10)
          inputRightPadding = originalRightPadding + $betterPlaceholder.outerWidth() + 2
          $input.css('padding-right', inputRightPadding)

          unless inputVal == ''
            $betterPlaceholder[0].classList.remove('hidden')

          $input.on 'focus.toggleBetterPlaceholder', (e) =>
            $input.css('padding-right', inputRightPadding)
            inputVal = $input.val()
            if inputVal == ''
              $betterPlaceholder[0].classList.add('hidden')
            else
              $betterPlaceholder[0].classList.remove('hidden')
          .on 'keyup.toggleBetterPlaceholder', (e) =>
            inputVal = $input.val()
            if inputVal == ''
              $betterPlaceholder[0].classList.add('hidden')
            else
              $betterPlaceholder[0].classList.remove('hidden')
          .on 'blur.toggleBetterPlaceholder', (e) =>
            $betterPlaceholder[0].classList.add('hidden')
            $input.css('padding-right', originalRightPadding)
