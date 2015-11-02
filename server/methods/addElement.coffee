Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  addElement: (x1, x2, x3) ->
    Elements.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      x1: x1
      x2: x2
      x3: x3

