Template.personLayout.helpers
  profileImage: ->
    element = Elements.findOne $and: [
      {'x1.value': @_id }
      {'x2.value': 'profileImage'}
    ]
    return element.x3.value
  familyName: ->
    element = Elements.findOne $and: [
      {'x1.value': @_id }
      {'x2.value': 'familyName'}
    ]
    return element.x3.value
  givenName: ->
    element = Elements.findOne $and: [
      {'x1.value': @_id }
      {'x2.value': 'givenName'}
    ]
    return element.x3.value

Template.personLayout.onRendered ->
  @$(".menu .item").tab()
