Template.login.events
  'submit form': (event) ->
    event.preventDefault()
    email = $('[name=email]').val()
    password = $('[name=password]').val()
    Meteor.loginWithPassword email, password, (error) ->
      if error
        alert error.reason
      else
        Router.go 'home'
      return
