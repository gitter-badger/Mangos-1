Meteor.publishComposite 'elements', (docId) ->
  find: ->
    # Find all actions by this user
    Elements.find {createdBy:docId},
      sort: createdAt: -1
  children: [
    {
      find: (action) ->
        # Find action createdBy. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Meteor.users.find { _id: action.createdBy },
          limit: 1
          fields: username: 1
    }
  ]

