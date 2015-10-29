$.fn.form.settings.rules.maxMangos = (value) ->
  mangos = Meteor.users.findOne(Meteor.userId).mangos
  if value <= mangos
    true

$.fn.form.settings.rules.minMangos = (value) ->
  if value >= 1
    true

$.fn.form.settings.rules.maxMangosOrga = (value) ->
  mangos = Organisations.findOne(Session.get "orgaId").mangos
  if value <= mangos
    true
