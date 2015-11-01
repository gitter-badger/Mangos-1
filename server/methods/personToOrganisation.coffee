Meteor.methods
  personToOrganisation: (orgaId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount

      #Add the Transaction amount to the organisation account
      Organisations.update orgaId,
        $inc:
          mangos: +amount

      #Add the Transaction to the Transactions Collection for History
      Transactions.insert
        collection: "transactions"
        createdAt: new Date()
        createdBy: Meteor.userId()
        type: "personToOrganisation"
        mangos: +amount
        sender: Meteor.userId()
        receiver: orgaId
        message: message
