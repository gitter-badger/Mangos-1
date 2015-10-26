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



Template.orgaProjects.onRendered ->
  @$('.dropdown').dropdown
    onChange: (value) ->
      Meteor.call 'addProjectToOrga', value, Session.get 'orgaId'
      $('.dropdown').dropdown('restore default')

Template.orgaProjects.events
  "click .giveWanted": (event) ->
    alert "clicked"
