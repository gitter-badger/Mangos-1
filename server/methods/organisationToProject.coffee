Meteor.methods
  organisationToProject: (orgaId, projectId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount

      #Get all actions belonging to this project
      actionsA = Actions.find(childOf: projectId).fetch()
      totalMangosWanted = 0
      totalMangosReceived = 0
      addMangosExtra = 0

      #Work around for accumulated Transactions
      transactionId =
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          mangos: +amount
          sender: orgaId
          message: message
          receiver: projectId
          type: "organisationToProject"

      #Calculate totals
      for action, i in actionsA
        totalMangosWanted += actionsA[i].mangosWanted
        totalMangosReceived += actionsA[i].mangosReceived
      wantedReceivedDiff = totalMangosWanted - totalMangosReceived

      for action, i in actionsA
        #Define amount of  mangos to be added
        if wantedReceivedDiff >= amount
          addMangos = (actionsA[i].mangosWanted / totalMangosWanted * amount)
        else
          extraMangos = (amount - wantedReceivedDiff)
          addMangos = (actionsA[i].mangosWanted - actionsA[i].mangosReceived)
          addMangosExtra = (actionsA[i].mangosWanted / totalMangosWanted * extraMangos)
        receiver = actionsA[i].createdBy

        #Add defined mangos to User account
        Meteor.users.update receiver,
          $inc:
            mangos: addMangos + addMangosExtra

        #Add the new recevied mangos to the action
        actionId = actionsA[i]._id
        Actions.update actionId,
          $inc:
            mangosReceived: addMangos
            mangosReceivedExtra: addMangosExtra

        #Add the Transaction to the Transactions Collection for History
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          mangos: addMangos + addMangosExtra
          sender: projectId
          message: message
          receiver: receiver
          action: actionId
          type: "projectToPerson"
          childOf: transactionId

        #Find share id of current action and project
        shareId = Shares.findOne '$and': [
          { childOf: actionsA[i].childOf }
          { createdBy: actionsA[i].createdBy }
        ]
        #Update the corresponding Share document
        Shares.update shareId,
          $inc:
            mangosReceived: addMangos
            mangosReceivedExtra: addMangosExtra
