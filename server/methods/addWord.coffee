Meteor.methods
  addWord:(text) ->
    console.log text
    Words.insert
      createdBy: Meteor.userId()
      createdAt: new Date()
      name: text
