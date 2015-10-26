Template.projectPeople.helpers
  shares: ->
    Shares.find {childOf: @_id}
  createdBy: ->
    Meteor.users.findOne @createdBy
  mangosWanted: ->
    @mangosWanted.toFixed(2)
  mangosReceived: ->
    @mangosReceived.toFixed(2)
  mangosReceivedExtra: ->
    @mangosReceivedExtra.toFixed(2)
