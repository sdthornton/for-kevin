namespace 'CutTheChi', (exports) ->
  class exports.TableSorter

    constructor: (table) ->
      @$table = $(table)
      @$tbody = @$table.find('tbody')
      @bindHeaders()

    bindHeaders: ->
      @$table.find('th').on 'click', @sortColumn

    sortColumn: (e) =>
      @$table.find('th').not(e.target)
        .removeClass('sorted-up sorted-down')
        .addClass('not-sorted')
      $head = $(e.target)
      orderBy = $(e.target).data('order')
      reverse = $(e.target).data('order-reverse')
      $fields = @$table.find("[data-#{orderBy}]")
      data = []
      ordered = []
      $fields.each (i, field) =>
        datum = $(field).data(orderBy)
        data.push(datum)

      isNumber = typeof(data[0]) == 'number'
      if isNumber
        data.sort((a,b) -> return a-b)
      else
        data.sort()

      if !!reverse
        data.reverse()
        $head.data('order-reverse', false)
          .removeClass('not-sorted sorted-up')
          .addClass('sorted-down')
      else
        $head.data('order-reverse', true)
          .removeClass('not-sorted sorted-down')
          .addClass('sorted-up')

      for datum in data
        $row = $("[data-#{orderBy}=\"#{datum}\"]").parent().detach()
        $row.appendTo(@$tbody)
