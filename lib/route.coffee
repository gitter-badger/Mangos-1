Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
Router.map ->
  @route 'register', path: '/register'
  @route 'login', path: '/login'
  @route 'home', path: '/'

  @route 'people', path: '/people'
  @route 'personLayout',
    path: '/people/:_id'
    data: ->
      Meteor.users.findOne @params._id

  @route 'elements', path: '/elements'
  @route 'singleElement',
    path: '/elements/:_id'
    data: ->
      Elements.findOne @params._id

  @route 'events', path: '/events'
  @route 'singleEvent',
    path: '/events/:_id'
    data: ->
      Events.findOne @params._id

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
