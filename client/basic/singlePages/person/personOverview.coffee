Template.personOverview.helpers
  personTimeline: ->
    actions = Actions.find().fetch()
    messages = Messages.find().fetch()
    transactions = Transactions.find().fetch()
    docs = actions.concat(messages, transactions)
    docs.sort (a, b) ->
      if a.createdAt > b.createdAt
        return 1
      if a.createdAt < b.createdAt
        return -1
      0
    return docs

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
  actionsCount: ->
    Actions.find({createdBy: @_id}).count()
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
  actions: ->
    Actions.find()
  createdBy: ->
    # We use this helper inside the {{#each posts}} loop, so the context
    # will be a action object. Thus, we can use this.authorId.
    Meteor.users.findOne @createdBy

Template.personOverview.onCreated ->
  @subscribe 'personActions'
  @subscribe 'personMessages'
  @subscribe 'personTransactions'

