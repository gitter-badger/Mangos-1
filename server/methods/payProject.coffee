Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  payProject: (projectId, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount

      #Get all actions belonging to this project
      actionsA = Actions.find(childOf: projectId).fetch()
      totalMangosWanted = 0
      totalMangosReceived = 0
      for action, i in actionsA
        totalMangosWanted += actionsA[i].mangosWanted
        totalMangosReceived += actionsA[i].mangosReceived
      wantedReceivedDiff = totalMangosWanted - totalMangosReceived

      if wantedReceivedDiff >= amount
        for action, i in actionsA
          addMangos = (actionsA[i].mangosWanted / totalMangosWanted * amount)
          receiver = actionsA[i].createdBy
          Meteor.users.update receiver,
            $inc:
              mangos: addMangos

          actionId = actionsA[i]._id
          Actions.update actionId,
            $inc:
              mangosReceived: addMangos

          #Add the Transaction to the Transactions Collection for History
          Transactions.insert
            createdAt: new Date()
            createdBy: Meteor.userId()
            mangos: addMangos
            sender: Meteor.userId()
            message: message
            receiver: receiver
            childOf: actionId
