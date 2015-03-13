do ->
  getCookie = (name) ->
    value = "; #{document.cookie}"
    parts = value.split("; #{name}=")
    if parts.length == 2
      return parts.pop().split(';').shift()

  csrfToken = getCookie('csrftoken');

  csrfParamMeta = document.createElement('meta')
  csrfParamMeta.name = 'csrf-param'
  csrfParamMeta.content = 'authenticity_token'
  document.head.appendChild(csrfParamMeta)

  csrfTokenMeta = document.createElement('meta')
  csrfTokenMeta.name = 'csrf-token'
  csrfTokenMeta.content = csrfToken
  document.head.appendChild(csrfTokenMeta)
