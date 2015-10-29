Template.orgaTransactions.helpers
  mangos: ->
    @mangos.toFixed(3)

  transactions: ->
    Transactions.find '$or': [
        { receiver: @_id }
        { sender: @_id }
      ],
      sort:
        createdAt: -1
  receiverProject: ->
    Projects.findOne(@receiver)
  receiverOrga: ->
    Organisations.findOne(@receiver)
  senderOrga: ->
    Organisations.findOne(@sender)

  createdBy: ->
    Meteor.users.findOne(@createdBy)
  mangos: ->
    @mangos.toFixed(3)
  edit: ->
   Session.get "edit"
  organisationToProject: ->
    if @type is "organisationToProject"
      return true


