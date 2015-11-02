Template.singleElement.helpers
  elements: ->
    Elements.find()
  docId: ->
    Session.set "docId", @_id

Template.singleElement.onCreated ->
  @subscribe "Elements"

Template.singleElement.onRendered ->
  @$('.addElement').form
    on: 'change'
    inline: true
    fields:
      x2:
        identifier: 'x2'
        rules: [
          {
            type: 'empty'
            prompt: 'Can not be empty'
          }

        ]
      x3:
        identifier: 'x3'
        rules: [
          {
            type: 'empty'
            prompt: 'Can not be empty'
          }

        ]

Template.singleElement.events
  'submit .addElement': (event) ->
    event.preventDefault()
    x1 = Session.get "docId"
    x2 = $('.addElement').form('get value', 'x2')
    x3 = $('.addElement').form('get value', 'x3')
    alert x1
    Meteor.call 'addElement', x1, x2, x3

