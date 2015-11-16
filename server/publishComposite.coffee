Meteor.publishComposite 'orgaLayout', (orgaId) ->
  return {
    find: ->
      Organisations.find { _id: orgaId }, limit: 1
  }
  @ready()

###
Meteor.publishComposite 'orgaOverview', (orgaId, limit) ->
  return {
    find: ->
      Transactions.find { childOf: orgaId },
        limit: limit
    children: [
      { find: (transaction) ->
        # Find post author. Even though we only want to return
        # one record here, we use "find" instead of "findOne"
        # since this function should return a cursor.
        Transactions.find { _id: transaction.authorId },
          limit: 1
          fields:
            mangos: 1
      }
    ]
  }
  @ready()
###
