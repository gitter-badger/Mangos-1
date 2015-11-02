Meteor.publishComposite 'personActions', (docId) ->
  Counts.publish this, 'actionCount', Actions.find {createdBy:docId}
  Counts.publish this, 'messageCount', Messages.find {createdBy:docId}
  find: ->
    # Find all actions by this user
    Actions.find {createdBy:docId},
      sort: createdAt: -1
      fields:
        createdAt: 1
        name: 1
        createdBy: 1
        childOf: 1
        time: 1
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
    {
      find: (action) ->
        # Find action createdBy. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Projects.find { _id: action.childOf },
          limit: 1
          fields:
            name: 1
    }
  ]

Meteor.publishComposite 'homeMessages',
  find: ->
    # Find the last 10 actions
    Messages.find {},
      sort: createdAt: -1
      limit: 25
  children: [
    {
      find: (message) ->
        Meteor.users.find { _id: message.createdBy },
          limit: 1
          fields: username: 1
    }
    {
      find: (message) ->
        Projects.find { _id: message.childOf },
          limit: 1
          fields: name: 1
    }
    {
      find: (message) ->
        Organisations.find { _id: message.childOf },
          limit: 1
          fields: name: 1
    }
    {
      find: (message) ->
        Actions.find { _id: message.childOf },
          limit: 1
          fields: name: 1
    }
  ]

Meteor.publishComposite 'subMessages', (docId) ->
  find: ->
    # Find the last 10 actions
    Messages.find {childOf: docId},
      sort: createdAt: -1
      limit: 20
  children: [
    {
      find: (message) ->
        Meteor.users.find { _id: message.createdBy },
          limit: 1
          fields: username: 1
    }
  ]

