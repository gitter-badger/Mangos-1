Template.orgaTransactions.helpers
  createdBy: ->
    Meteor.users.findOne @createdBy
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


