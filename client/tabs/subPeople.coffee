Template.subPeople.helpers
  shares: ->
    Shares.find {childOf: @_id}
  percent: ->
    totalTime = Projects.findOne(@childOf).totalTime
    (@totalTime / totalTime * 100).toFixed(3)
  createdBy: ->
    Meteor.users.findOne @createdBy
