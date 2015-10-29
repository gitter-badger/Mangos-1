Template.orgaProjects.helpers
  projects: ->
    Projects.find childOf: @_id
  projectsSelect: ->
    Projects.find childOf: $ne: @_id,
      sort:
        name: 1
  orgaId: ->
    Session.set 'orgaId', @_id
  createdBy: ->
    Meteor.users.findOne @createdBy
  peopleCount: ->
    Shares.find({childOf: @_id}).count()
  actionsCount: ->
    Actions.find({childOf: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalTime: ->
    array = Actions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for actions, i in array
      total += array[i].time
      console.log total
    return total.toFixed(2)
  mangosReceived: ->
    array = Actions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for actions, i in array
      total += array[i].mangosReceived
      console.log total
    return total.toFixed(2)
  mangosWanted: ->
    array = Actions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for actions, i in array
      total += array[i].mangosWanted
      console.log total
    return total.toFixed(2)
  projectName: ->
    Session.get "projectName"

Template.orgaProjects.onRendered ->
  @$('.addProjectToOrga.dropdown').dropdown
    onChange: (value) ->
      Meteor.call 'addProjectToOrga', value, Session.get 'orgaId'
      $('.dropdown').dropdown('restore default')
  @$(".mangosLove.dropdown").dropdown()
  @$('.give').form
    on: 'change'
    inline: true
    fields:
      amount:
        identifier: 'amount'
        rules: [
          {
            type: 'empty'
            prompt: 'please enter a value'
          }
          {
            type: 'maxMangosOrga'
            prompt: "You don't have so many Mangos"
          }
          {
            type: 'minMangos'
            prompt: 'Come on, minimum 1 Mango'
          }
        ]
      mangosLove:
        identifier: 'mangosLove'
        rules: [
          {
            type: 'empty'
            prompt: 'please choose a value'
          }
        ]
      message:
        identifier: 'message'
        optional: true
        rules: [
          {
            type   : 'maxLength[120]',
            prompt : 'Please enter at most 120 characters'
          }
          {
            type   : 'minLength[3]',
            prompt : 'Please enter at least 3 characters'
          }
        ]


Template.orgaProjects.events
  'click .openModal': (event, template) ->
    self = this
    Session.set "projectName", self.name
    $('.modal').modal(
      autofocus: true
      allowMultiple: true
      onHidden: ->
        $('.give').form('reset')
        $('.give').form('clear')
        $('.give').removeClass('error')
      onApprove: ->
        if $('.give').form('validate form')
          amount = $('.give').form('get value', 'amount')
          message = $('.give').form('get value', 'message')
          love = $('.give').form('get value', 'mangosLove')
          projectId = self._id
          orgaId = Session.get "orgaId"
          alert "orga: " + orgaId + "project: " + projectId + "message: " + message + "love factor: " + love + "amount: " + amount
          Meteor.call 'organisationToProject', orgaId, projectId, amount, love, message
        else
          false
    ).modal 'show'



