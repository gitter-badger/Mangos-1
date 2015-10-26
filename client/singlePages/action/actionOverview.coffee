Template.actionOverview.helpers
  createdBy: ->
    Meteor.users.findOne @createdBy
  transactionsCount: ->
    Transactions.find({action: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  mangosReceived: ->
    @mangosReceived.toFixed(2)
  mangosWanted: ->
    @mangosWanted.toFixed(2)
  mangosWanted: ->
    @mangosWanted.toFixed(2)
  mangosReceivedExtra: ->
    @mangosReceivedExtra.toFixed(2)
  transactions: ->
    Transactions.find {action: @_id},
      sort:
        createdAt: -1
  mangos: ->
    @mangos.toFixed(3)


