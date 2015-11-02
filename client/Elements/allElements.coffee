Template.elements.helpers
  elements: ->
    Elements.find {},
      sort:
        createdAt: -1

Template.elements.onRendered ->
  $('.addStringElement').validate
    rules:
      name:
        required: true
        minlength: 3
        maxlength: 50
    messages:
      name:
        minlength: "Minimum 3 Characters, be more creative"
        maxlength: "Maximum 50 Characters, be less creative"

Template.elements.events
  'submit .addStringElement': (event) ->
    event.preventDefault()
    elementType = $('.addStringElement').form('get value', 'elementType')
    contains = $('.addStringElement').form('get value', 'contains')
    expectedType = $('.addStringElement').form('get value', 'expectedType')
    utilizedWith = $('.addStringElement').form('get value', 'utilizedWith')
    definition = $('.addStringElement').form('get value', 'definition')
    Meteor.call 'addStringElement', contains, elementType, expectedType, utilizedWith, definition

