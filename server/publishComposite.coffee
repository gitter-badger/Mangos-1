Meteor.publishComposite 'personActions',
  find: ->
    # Find the last 10 actions
    Actions.find {},
      sort: createdAt: -1
      limit: 10
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

Meteor.publishComposite 'personMessages',
  find: ->
    # Find the last 10 actions
    Messages.find {},
      sort: createdAt: -1
      limit: 10
  children: [
    {
      find: (message) ->
        # Find action createdBy. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Meteor.users.find { _id: message.createdBy },
          limit: 1
          fields: username: 1
    }
  ]

Meteor.publishComposite 'personTransactions',
  find: ->
    # Find the last 10 actions
    Transactions.find {},
      sort: createdAt: -1
      limit: 10
  children: [
    {
      find: (transaction) ->
        # Find action createdBy. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Meteor.users.find { _id: transaction.createdBy },
          limit: 1
          fields: username: 1
    }
  ]
