Template.register.events
  'submit form': (event) ->
    event.preventDefault()
    Accounts.createUser {
      email: $('[name=email]').val()
      password: $('[name=password]').val()
      firstname: $('[name=firstname]').val()
      lastname: $('[name=lastname]').val()
    }, (error) ->
      if error
        alert error.reason
      else
        Router.go 'home'
      return
