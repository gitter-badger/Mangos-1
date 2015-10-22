Template.orgaLayout.helpers
  maintainer: ->
    Meteor.users.findOne @createdBy
  transactionCount: ->
    Transactions.find({receiver: @_id}).count()
  projectCount: ->
    Projects.find({childOf: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()

Template.orgaLayout.onRendered ->
  @$('textarea').autosize()
  @$(".menu .item").tab()
  $('.payProject').validate
    rules:
      amount:
        required: true
        min: 0
        max: (event) ->
          Meteor.user().mangos
        number: true
      message:
        minlength: 1
        maxlength: 120
    messages:
      amount:
        min: "You are cheeky"
        max: "You don't have enough mangos"

Template.orgaLayout.events
  'submit .personToOrganisation': (event) ->
    event.preventDefault()
    amount = event.target.amount.value
    message = event.target.message.value
    orgaId = @._id
    Meteor.call 'personToOrganisation', orgaId, amount, message
    event.target.message.value = null
    event.target.amount.value = null
    return


