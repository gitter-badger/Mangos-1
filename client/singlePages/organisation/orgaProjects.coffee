Template.orgaProjects.helpers
  projects: ->
    Projects.find childOf: @_id
  projectsSelect: ->
    Projects.find childOf: $ne: @_id,
      sort:
        name: 1
  id: ->
    Session.set 'orgaId', @_id
  createdBy: ->
    Meteor.users.findOne @createdBy
  peopleCount: ->
    Shares.find({childOf: @_id}).count()
  transactionsCount: ->
    Transactions.find({childOf: @_id}).count()
  actionsCount: ->
    Actions.find({childOf: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangos: ->
    array = Transactions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for transfers, i in array
      total += array[i].mangos
      console.log total
    return total.toFixed(2)

Template.orgaProjects.onRendered ->
  @$('.dropdown').dropdown
    onChange: (value) ->
      Meteor.call 'addProjectToOrga', value, Session.get 'orgaId'
      $('.dropdown').dropdown('restore default')

Template.orgaProjects.events
  "submit .addProject": (event) ->
    event.preventDefault()
    projectId = event.target.name.value
    alert projectId.name
    orgaId = @_id
    ###Meteor.call 'addProjectToOrga', projectId
    Session.set 'ProjectId', null
    event.target.name.value = null
    return###



