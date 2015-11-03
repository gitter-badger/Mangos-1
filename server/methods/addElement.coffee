Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  addElement: (x1, x1Type, x2, x2Type, x3, x3Type) ->
    Elements.insert
      createdAt: new Date()
      createdBy: Meteor.userId()
      x1:
        type: x1Type
        value: x1
      x2:
        type: x2Type
        value: x2
      x3:
        type: x3Type
        value: x3

