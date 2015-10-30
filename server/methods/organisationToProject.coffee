Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  organisationToProject: (orgaId, projectId, amount, love, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #---------  MangoLove Transaction to CO | OPEN -----------#
       #Calculate the mangolove amount
      mangoLove = amount * love
      if love > 0
        coOpen = Organisations.findOne { name: "CO | OPEN" }
        #Remove the mangoLove amount from the Senders Account
        Meteor.users.update Meteor.userId(),
          $inc:
            mangos: -mangoLove

        #Add the mangoLove amount to the organisation account
        Organisations.update coOpen,
          $inc:
            mangos: +mangoLove

        #Add the mangoLove transaction to the Transactions Collection for History
        Transactions.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          type: "organisationToOrganisation"
          mangos: +mangoLove
          sender: orgaId
          receiver: coOpen._id
          message: "MangoLove"

      #---------  Transaction to Project -----------#

      #Remove the Transaction amount from the Senders Account
      Organisations.update orgaId,
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
