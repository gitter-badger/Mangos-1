Meteor.methods
#Transfer mangos to project and distribute according to shares to project members
  addUpload: (fileInfo) ->
    Uploads.insert fileInfo
    url = fileInfo.url
    Elements.insert
      createdBy: Meteor.userId()
      createdAt: new Date()
      x1:
        type: "person"
        value: Meteor.userId()
      x2:
        type: "string"
        value: "profileImage"
      x3:
        type: "url"
        value: url

  editProfile: (givenName, familyName) ->
    Elements.insert
      createdBy: Meteor.userId()
      createdAt: new Date()
      x1:
        type: "person"
        value: Meteor.userId()
      x2:
        type: "string"
        value: "givenName"
      x3:
        type: "string"
        value: givenName

    Elements.insert
      createdBy: Meteor.userId()
      createdAt: new Date()
      x1:
        type: "person"
        value: Meteor.userId()
      x2:
        type: "string"
        value: "familyName"
      x3:
        type: "string"
        value: familyName
