Meteor.publish 'Uploads', ->
  Uploads.find()

Meteor.publish 'People', ->
  Meteor.users.find()

Meteor.publish 'Elements', ->
  Elements.find()


Meteor.publishComposite 'elementComp', (docId) ->
  find: ->
    # Find all actions by this user
    Elements.find {},
      sort: createdAt: -1
  children: [
    {
      find: (element) ->
        # Find action createdBy. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Meteor.users.find { _id: element.createdBy },
          limit: 1
    }
  ]
