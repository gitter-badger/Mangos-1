Template.orgaHistory.helpers
  history: ->
    History.find {variationOf: @_id},
      sort:
        createdAt: -1
  maintainer: ->
    Meteor.users.findOne @createdBy
