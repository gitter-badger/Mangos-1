#Publish all Users
Meteor.publish 'People', ->
  Meteor.users.find()
#Publish all Transactions
Meteor.publish 'Transactions', ->
  Transactions.find {},
    limit: 100,
    sort:
      createdAt: -1
#Publish all Projects
Meteor.publish 'Projects', ->
  Projects.find()
#Publish all Verifications
Meteor.publish 'Verifications', ->
  Verifications.find {},
    limit: 25,
    sort:
      createdAt: -1
#Publish all Actions
Meteor.publish 'Actions', ->
  Actions.find()
#Publish all Shares
Meteor.publish 'Shares', ->
  Shares.find()
#Publish all Messages
Meteor.publish 'Messages', ->
  Messages.find()
#Publish all Organisations
Meteor.publish 'Organisations', ->
  Organisations.find()
#Publish all History
Meteor.publish 'History', ->
  History.find()

#Publish all Objects
Meteor.publish 'Objects', ->
  Objects.find()

Meteor.publish 'orgaOverview', (orgaId, limit) ->
  Transactions.find $or: [
    { receiver: orgaId }
    { sender: orgaId }
  ],
    limit: limit,
    sort:
      createdAt: -1

###
Meteor.publish 'orgaOverview', (orgaId, limit) ->
  Transactions.find $or: [
    { receiver: orgaId }
    { sender: orgaId }
  ]
  return @ready()###
