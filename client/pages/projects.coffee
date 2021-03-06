Template.projects.helpers
  projects: ->
    Projects.find {},
      sort:
        totalTime: -1
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
  mangosReceivedExtra: ->
    array = Actions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for actions, i in array
      total += array[i].mangosReceivedExtra
      console.log total
    return total.toFixed(2)

Template.projects.onRendered ->
  $('.addProject').validate
    rules:
      name:
        required: true
        minlength: 3
        maxlength: 50
    messages:
      name:
        minlength: "Minimum 3 Characters, be more creative"
        maxlength: "Maximum 50 Characters, be less creative"

Template.projects.events
  'submit .addProject': (event) ->
    event.preventDefault()
    name = event.target.name.value
    Meteor.call 'addProjects', name
    event.target.name.value = null
