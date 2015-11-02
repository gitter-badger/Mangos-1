Template.actionLayout.helpers
  maintainer: ->
    Meteor.users.findOne @createdBy

Template.actionLayout.onRendered ->
  @$('textarea').autosize()
  @$(".menu .item").tab()

