Template.personOverview.helpers
  elements: ->
    Elements.find $or: [
      {'x1.value': @_id}
      {'x3.value': @_id}
    ],
      sort:
        createdAt: -1
  profileImage: ->
    element = Elements.findOne $and: [
      {'x1.value': @createdBy }
      {'x2.value': 'profileImage'}
    ]
    return element.x3.value

  givenName: ->
    element = Elements.findOne $and: [
      {'x1.value': @createdBy }
      {'x2.value': 'givenName'}
    ]
    return element.x3.value

  familyName: ->
    element = Elements.findOne $and: [
      {'x1.value': @createdBy }
      {'x2.value': 'familyName'}
    ]
    return element.x3.value

