Template.orgaOverview.helpers
  transactionCount: ->
    Transactions.find({receiver: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  totalMangos: ->
    @mangos.toFixed(3)

  transactions: ->
    Transactions.find {receiver: @_id},
      sort:
        createdAt: -1
  receiver: ->
    Meteor.users.findOne(@receiver)
  sender: ->
    Meteor.users.findOne(@sender)
  mangos: ->
    @mangos.toFixed(3)
  edit: ->
   Session.get "edit"

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
