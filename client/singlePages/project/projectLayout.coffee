Template.projectLayout.helpers
  maintainer: ->
    Meteor.users.findOne(@createdBy)
  peopleCount: ->
    Shares.find({childOf: @_id}).count()
  transactionsCount: ->
    Transactions.find({sender: @_id}).count()
  actionsCount: ->
    Actions.find({childOf: @_id}).count()
  messageCount: ->
    Messages.find({childOf: @_id}).count()
  editCount: ->
    History.find({variationOf: @_id}).count()

Template.projectLayout.onRendered ->
  @$("textarea").autosize()
  @$(".menu .item").tab()
  @$('.give').form
    on: 'change'
    inline: true
    fields:
      amount:
        identifier: 'amount'
        rules: [
          {
            type: 'empty'
            prompt: 'please enter a value'
          }
          {
            type: 'maxMangos'
            prompt: "You don't have so many Mangos"
          }
          {
            type: 'minMangos'
            prompt: 'Come on, minimum 1 Mango'
          }
        ]
      message:
        identifier: 'message'
        optional: true
        rules: [
          {
            type   : 'maxLength[120]',
            prompt : 'Please enter at most 120 characters'
          }
          {
            type   : 'minLength[3]',
            prompt : 'Please enter at least 3 characters'
          }
        ]


Template.projectLayout.events
  'click .openModal': (event, template) ->
    self = this
    $('.modal').modal(
      autofocus: true
      allowMultiple: true
      onHide: ->
        $('.give').form('reset')
        $('.give').form('clear')
        $('.give').removeClass('error')
      onApprove: ->
        if $('.give').form('validate form')
          amount = $('.give').form('get value', 'amount')
          message = $('.give').form('get value', 'message')
          projectId = self._id
          Meteor.call 'payProject', projectId, amount, message
        else
          false
    ).modal 'show'

