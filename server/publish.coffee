#Publish all Users
Meteor.publish 'People', ->
  Meteor.users.find()

#Publish all Organisations
Meteor.publish 'Organisations', ->
  Organisations.find()

#Publish all Projects
Meteor.publish 'Projects', ->
  Projects.find()

#Publish all History
Meteor.publish 'History', ->
  History.find()

#Publish 25 Transactions
Meteor.publish 'Transactions', ->
  Transactions.find {},
    sort:
      createdAt: -1
    limit: 20
#Publish all Verifications
Meteor.publish 'Verifications', ->
  Verifications.find()
#Publish all Actions
Meteor.publish 'Actions', ->
  Actions.find {},
    sort:
      createdAt: -1
    limit: 25

#Publish all Shares
Meteor.publish 'Shares', ->
  Shares.find()
###
Meteor.publish 'Elements', ->
  Elements.find()

Meteor.publish 'Relations', ->
  Relations.find()

Meteor.publish 'Events', ->
  Events.find()
  ###
