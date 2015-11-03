Template.home.helpers
  user: ->
    Meteor.user()
  specificFormData: ->
  {
    id: @_id
    other: @other
    hard: 'Lolcats'
  }
  people: ->
    Meteor.users.find()

  elements: ->
    Elements.find {},
      sort:
        createdAt: -1

Template.home.onCreated ->
  @subscribe "Elements"

Template.home.onRendered ->
  Uploader.finished = (index, fileInfo, templateContext) ->
    Meteor.call 'addUpload', fileInfo
    url = fileInfo.url
    Meteor.call 'addImage', url
  return

Template.home.events
  'submit .editProfile': (event) ->
    event.preventDefault()
    firstname = $('.editProfile').form('get value', 'firstname')
    lastname = $('.editProfile').form('get value', 'lastname')
    Meteor.call 'editProfile', firstname, lastname

