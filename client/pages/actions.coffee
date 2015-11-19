Template.actions.helpers
  actions: ->
    Actions.find {},
      sort:
        createdAt: -1
  projects: ->
    Projects.find @childOf
  createdBy: ->
    Meteor.users.findOne @createdBy
  mangosWanted: ->
    @mangosWanted.toFixed(2)
  mangosReceived: ->
    @mangosReceived.toFixed(2)
  

Template.actions.onRendered ->
  addObject = Objects.findOne({type: "addAction"})
  $("."+addObject.type).form
    on: addObject.on
    inline: addObject.inline
    fields: addObject.fields