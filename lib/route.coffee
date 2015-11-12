Router.configure layoutTemplate: 'layout'
Router.map ->
  @route 'register', path: '/register'
  @route 'login', path: '/login'
  @route 'home', path: '/'
  @route 'verifications', path: '/verifications'

  @route 'people', path: '/people'
  @route 'personLayout',
    path: '/people/:_id'
    data: ->
      Meteor.users.findOne @params._id

  @route 'objects', path: '/objects'
  @route 'objectLayout',
    path: '/objects/:_id'
    data: ->
      Objects.findOne @params._id

  @route 'transactions', path: '/transactions'
  @route 'projects', path: '/projects'
  @route 'projectLayout',
    path: '/projects/:_id'
    data: ->
      Projects.findOne @params._id

  @route 'actions', path: '/actions'
  @route 'actionLayout',
    path: '/actions/:_id'
    data: ->
      Actions.findOne @params._id

  @route 'organisations', path: '/organisations'
  @route 'orgaLayout',
    path: '/organisations/:_id'
    data: ->
      Organisations.findOne @params._id


#Redirect User when not Loggedin to the Login template
Router.onBeforeAction (->
  if !Meteor.userId()
    @render 'login'
  else
    @next()
  return
), except: [ 'register' ]


#Set Session for active menu link
Router.onAfterAction(() ->
  Session.set('active', @route.getName())
)
