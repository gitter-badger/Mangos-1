Template.elements.helpers
  elements: ->
    Elements.find {},
      sort:
        createdAt: -1

Template.elements.onCreated ->
  @subscribe "Elements"
