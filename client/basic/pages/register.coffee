Template.register.onRendered ->
  @$('.register').form
    on: 'change'
    inline: true
    fields:
      email:
        identifier: 'email'
        rules: [
          {
            type: 'empty'
            prompt: 'Please enter your email'
          }
          {
            type: 'email'
            prompt: "You have to enter a valid email"
          }
        ]
      firstname:
        identifier: 'firstname'
        rules: [
          {
            type: 'empty'
            prompt: 'Please enter your firstname'
          }
        ]
      lastname:
        identifier: 'lastname'
        rules: [
          {
            type: 'empty'
            prompt: 'Please enter your lastname'
          }
        ]
      password:
        identifier: 'password'
        rules: [
          {
            type: 'empty'
            prompt: 'Can not be empty'
          }
          {
            type: 'minLength[8]'
            prompt: 'Minimum 8 characters'
          }
        ]
      passwordAgain:
        identifier: 'passwordAgain'
        rules: [
          {
            type: 'empty'
            prompt: 'Can not be empty'
          }
          {
            type: 'match[password]'
            prompt: 'Password is not matching'
          }
        ]


Template.register.events
  'submit form': (event) ->
    if $('.register').form('validate form')
      event.preventDefault()
      Accounts.createUser {
        email: $('[name=email]').val()
        password: $('[name=password]').val()
        profile:
          firstname: $('[name=firstname]').val()
          lastname: $('[name=lastname]').val()
      }, (error) ->
        if error
          alert error.reason
        else
          Router.go 'home'
        return
