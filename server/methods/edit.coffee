Meteor.methods
  editDescription :(projectId, content, createdBy) ->
    if createdBy is Meteor.userId()
      Projects.update projectId, $set: description: content
      History.insert {
        createdBy: Meteor.userId()
        createdAt: new Date()
        collection: "Projects"
        versionOf: projectId
        action: "update"
        field: "description"
        value: content
      }
    else
      console.log "nope creating a new variation"


  merge: (id, name, createdBy) ->
    Bundles.update id, $set: title: title
    History.insert {
      createdBy: createdBy
      createdAt: new Date()
      collection: "Bundles"
      versionOf: id
      action: "merge"
      field: "name"
      value: name
    }

