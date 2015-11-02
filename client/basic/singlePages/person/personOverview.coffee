Template.personOverview.helpers
  actions: ->
    Actions.find {},
      sort:
        createdAt: -1

  project: ->
    Projects.findOne @childOf

  mangos: ->
    @mangos.toFixed(3)
  totalTime: ->
    array = Shares.find({createdBy: @_id}).fetch()
    console.log array
    total = 0
    for time, i in array
      total += array[i].totalTime
      console.log total
    return total
  messageCount: ->
    Messages.find({createdBy: @_id}).count()
  transactions: ->
    Transactions.find { $or: [
      { sender: @_id }
      { receiver: @_id }
    ]}, sort: createdAt: -1
  sender: ->
    Meteor.users.findOne @sender
  receiver: ->
    Meteor.users.findOne @receiver
  receiverOrga: ->
    Organisations.findOne @receiver
  mangosDestroyed: ->
    @mangosDestroyed.toFixed(2)
  mangosGenerated: ->
    @mangosGenerated.toFixed(2)
  messages: ->
    Messages.find()
  createdBy: ->
    Meteor.users.findOne @createdBy

Template.personOverview.onCreated ->
  docId = Template.parentData(0)._id
  @subscribe 'personActions', docId
  Counts.get 'actionCount'
  Counts.get 'messageCount'
