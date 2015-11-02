Template.actions.helpers
  actions: ->
    Actions.find()
  projects: ->
    Projects.find @childOf
  createdBy: ->
    Meteor.users.findOne @createdBy
  mangosWanted: ->
    @mangosWanted.toFixed(2)
  mangosReceived: ->
    @mangosReceived.toFixed(2)

Template.actions.onCreated ->
  @subscribe 'Actions'
