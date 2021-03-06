Template.orgaOverview.helpers
  transactionCount: ->
    Transactions.find({receiver: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangos: ->
    @mangos.toFixed(3)

  transactions: ->
    Transactions.find()
  receiverProject: ->
    Projects.findOne(@receiver)
  receiverOrga: ->
    Organisations.findOne(@receiver)
  senderOrga: ->
    Organisations.findOne(@sender)

  createdBy: ->
    Meteor.users.findOne(@createdBy)
  mangos: ->
    @mangos.toFixed(3)
  edit: ->
   Session.get "edit"
  organisationToProject: ->
    if @type is "organisationToProject"
      return true
  organisationToOrganisation: ->
    if @type is "organisationToOrganisation"
      return true

Template.orgaOverview.onCreated ->
  orgaId = Router.current().params._id
  limit = 20
  Meteor.subscribe 'orgaOverview', orgaId, limit

Template.orgaOverview.onRendered ->
  $('textarea').autosize()
  Session.set "edit", "none"

Template.orgaOverview.events
  'blur .edit': (event, template) ->
    event.preventDefault()
    content = $(event.target).val()
    orgaId = @_id
    createdBy = @createdBy
    Session.set "edit", "none"
    Meteor.call 'editOrgaDescription', orgaId, content, createdBy
  'dblclick .edit': (event) ->
    Session.set "edit", "block"
