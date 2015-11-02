Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  addStringElement: (contains, context) ->
    elementId =
      Elements.insert
        createdAt: new Date()
        createdBy: Meteor.userId()
        context: context
        contains: contains
        relations: []

