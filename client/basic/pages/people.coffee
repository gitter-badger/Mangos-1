Template.people.helpers
  people: ->
    Meteor.users.find()
Template.people.onCreated ->
  @subscribe 'People'




