Template.objects.helpers
  objects: ->
    Objects.find()
  types: ->
    typeId =
      Objects.findOne({type: "@type"})._id
    Objects.find $or: [ {type: typeId}, {type: "@type"} ]

Template.objects.onRendered ->
  @$(".dropdown").dropdown()
  @$('.addProperty').dropdown
    onChange: (value) ->
      alert value
      $('.dropdown').dropdown('restore default')
