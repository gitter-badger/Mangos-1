Meteor.methods
  #Transfer Amount from Person to Project and back to Person
  addTransaction: (receiver, amount, message) ->
    if (Meteor.user().verified and amount <= Meteor.user().mangos)
      #Remove the Transaction amount from the Senders Account
      Meteor.users.update Meteor.userId(),
        $inc:
          mangos: -amount

      #Add the Transaction amount to Receiver Account
      Meteor.users.update receiver,
        $inc:
          mangos: amount

      #Add the Transaction to the Transaction Collection for History
      Transactions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        mangos: amount
        sender: Meteor.userId()
        receiver: receiver
        message: message

  #Create new Project
  addProjects: (name) ->
    if (Meteor.user().verified)
      projectId =
        Projects.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          banner: "/banner.png"
          name: name
          totalTime: 1
          description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea ta."
      factor = 100
      mangosWanted = (1 / 60 * factor)
      Actions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        name: "Created project"
        time: 1
        factor: factor
        mangosWanted: mangosWanted
        mangosReceived: 0
        mangosReceivedExtra: 0
        childOf: projectId
        status: "Done"

      Shares.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        childOf: projectId
        totalTime: 1
        mangosWanted: mangosWanted
        mangosReceived: 0
        mangosReceivedExtra: 0

  #Add new Action to project
  addAction: (name, min, projectId) ->
    factor = 100
    mangosWanted = (min / 60 * factor)
    if (Meteor.user().verified)
      Actions.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        name: name
        time: min
        factor: factor
        mangosWanted: mangosWanted
        mangosReceived: 0
        mangosReceivedExtra: 0
        childOf: projectId
        status: "Done"

      #Find the respective share document for this user and project
      shareId = Shares.findOne '$and': [
        { childOf: projectId }
        { createdBy: Meteor.userId() }
      ]
      console.log shareId
      if shareId
        #Find all actions belonging to this share
        actionsA = Actions.find('$and': [
          {childOf: projectId}
          {createdBy: Meteor.userId() }
        ]).fetch()
        console.log actionsA
        #Calculate totalTime on this share
        totalTime = 0
        totalMangosWanted = 0
        for action, i in actionsA
          totalTime += actionsA[i].time
          totalMangosWanted += actionsA[i].mangosWanted

        console.log totalTime + totalMangosWanted
        #Enter totals into share document
        Shares.update shareId,
          $set:
            totalTime: totalTime
            mangosWanted: totalMangosWanted

      #Create new share document
      else
        Shares.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          childOf: projectId
          totalTime: min
          mangosWanted: mangosWanted
          mangosReceived: 0
          mangosReceivedExtra: 0


  #Verify a Person
  verifyPerson: (person) ->
    if (Meteor.user().verified)
      currentAge = Meteor.users.findOne(person).years
      if(person != Meteor.userId() and Meteor.users.findOne(person).verifyLevel > 0)
        Meteor.users.update person,
          $set:
            verifiedAt: currentAge
        #Add the Verification to the Verifications Collection
        Verifications.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          verifiedPerson: person
          verifiedAt: currentAge
      else
        console.log "You can verify yourself or this person"
    else
      console.log "Your are not allowed to verify"

  addMessage: (projectId, message) ->
    if (Meteor.user().verified)
      Messages.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        message: message
        childOf: projectId

 #Create new Project
  addOrganisation: (name) ->
    if (Meteor.user().verified)
      organisationId =
        Organisations.insert
          createdAt: new Date()
          createdBy: Meteor.userId()
          banner: "/banner.png"
          mangos: 0
          name: name
          mangosDestroyed: 0
          description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea ta."

  addProjectToOrga: (projectId, orgaId) ->
    if (Meteor.user().verified and Organisations.findOne(orgaId).createdBy is Meteor.userId())
      Projects.update projectId,
        $addToSet:
          childOf: orgaId
