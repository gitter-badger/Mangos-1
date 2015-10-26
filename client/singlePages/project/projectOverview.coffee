Template.projectOverview.helpers
  createdBy: ->
    Meteor.users.findOne @createdBy
  user: ->
    Meteor.users.findOne(@createdBy)
  peopleCount: ->
    Shares.find({childOf: @_id}).count()
  transactionsCount: ->
    Transactions.find({childOf: @_id}).count()
  actionsCount: ->
    Actions.find({childOf: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangosReceived: ->
    array = Actions.find({childOf: @_id}).fetch()
    total = 0
    for transfers, i in array
      total += array[i].mangosReceived
    return total.toFixed(2)
  totalMangosWanted: ->
    array = Actions.find({childOf: @_id}).fetch()
    total = 0
    for transfers, i in array
      total += array[i].mangosWanted
    return total.toFixed(2)
  totalMangosExtra: ->
    array = Actions.find({childOf: @_id}).fetch()
    total = 0
    for transfers, i in array
      total += array[i].mangosReceivedExtra
    return total.toFixed(2)
  totalTime: ->
    array = Actions.find({childOf: @_id}).fetch()
    console.log array
    total = 0
    for time, i in array
      total += array[i].time
      console.log total
    return total
  transactions: ->
    Transactions.find {receiver: @_id},
      sort:
        createdAt: -1
  receiver: ->
    Meteor.users.findOne(@receiver)
  sender: ->
    Meteor.users.findOne(@sender)
  mangos: ->
    @mangos.toFixed(3)
  action: ->
    Actions.findOne @action
  shares: ->
    Shares.find {childOf: @_id}
  words: ->
    Words.find()

Template.projectOverview.onRendered ->
  @$('textarea').autogrow()

Template.projectOverview.events
  'change .edit': (event, template) ->
    event.preventDefault()
    content = $(event.target).val()
    projectId = @_id
    createdBy = @createdBy
    Meteor.call 'editDescription', projectId, content, createdBy

