Template.orgaOverview.helpers
  transactionCount: ->
    Transactions.find({receiver: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangos: ->
    @mangos.toFixed(3)

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

