Template.projectHistory.helpers
  history: ->
    History.find {versionOf: @_id},
      sort:
        createdAt: -1
  maintainer: ->
    Meteor.users.findOne @createdBy
