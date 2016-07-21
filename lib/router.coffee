Router.onAfterAction () ->
  Session.set('active', @route.getName())

Router.route '/bots/:_id/addresses/:networkHandleName',
  name: 'networkAddressShow'
  waitOn: ->
    Meteor.subscribe 'bot', @params._id
  data: ->
    Bots.findOne()
  action: ->
    @render 'networkAddressShow'
# ********** NPR *************
Router.route '/number_porting_requests',
  name: 'numberPortingRequestList'
  waitOn: ->
    Meteor.subscribe 'numberPortingRequests'
  action: ->
    @render 'numberPortingRequestList'
Router.route '/number_porting_requests/new',
  name: 'numberPortingRequestNew'
  action: ->
    @render 'numberPortingRequestNew'
Router.route '/number_porting_requests/:_id/edit',
  name: 'numberPortingRequestEdit'
  layoutTemplate: 'noAuthLayout'
  waitOn: ->
    Meteor.subscribe 'numberPortingRequest', @params._id
  data: ->
    NumberPortingRequests.findOne @params._id
  action: ->
    @render 'numberPortingRequestEdit'
  controller: 'UnauthenticatedController'
Router.route '/number_porting_requests/:_id',
  name: 'numberPortingRequestShow'
  layoutTemplate: 'noAuthLayout'
  waitOn: ->
    Meteor.subscribe 'numberPortingRequest', @params._id
  data: ->
    NumberPortingRequests.findOne @params._id
  action: ->
    @render 'numberPortingRequestShow'
  controller: 'UnauthenticatedController'
# ------------ END --------------
Router.route '/port_start_notifications/new',
  name: 'portStartNotificationNew'
  action: ->
    @render 'portStartNotificationNew'
  waitOn: ->
    Meteor.subscribe 'numberPortingRequestsByIds', Session.get('nprIdsToPort')
# ********** Accounts ********** //
Router.route '/accounts/new',
  layoutTemplate: 'libraryLayout'
  name: 'accountsNew'
  action: ->
    @render 'accountsNew'
Router.route '/accounts/:_id',
  name: 'accountPage'
  waitOn: ->
    Meteor.subscribe 'account', @params._id
    Meteor.subscribe 'bots', @params._id
    Meteor.subscribe 'networkHandles', @params._id
    Meteor.subscribe 'scripts'
  data: ->
    Meteor.users.findOne @params._id
  action: ->
    @render 'accountPage'
# ---------- END -------------
Router.route '/conversations/:_id',
  waitOn: ->
    Meteor.subscribe 'session', @params._id
  data: ->
    Sessions.findOne()
  action: ->
    @render 'conversationDetails'
Router.route '/network_handles/:accountId',
  waitOn: ->
    Meteor.subscribe 'networkHandles', @params.accountId
    Meteor.subscribe 'rooms', @params.accountId
  data: ->
    CustomerAccounts.findOne @params.accountId
  action: ->
    @render 'networkHandlePage'
Router.configure
  layoutTemplate: 'masterLayout'
  loadingTemplate: 'loading'
  controller: 'AuthenticatedController'
Router.route '/accountsList',
  name: 'accountsList'
  action: ->
    @render 'accountsList'
  layoutTemplate: 'libraryLayout'
  waitOn: ->
    Meteor.subscribe 'account', @params._id
    Meteor.subscribe 'bots', @params._id
    Meteor.subscribe 'networkHandles', @params._id
    Meteor.subscribe 'scripts'
  data: ->
    Meteor.users.find()
Router.route '/',
  waitOn: ->
    Meteor.subscribe 'bots'
  template: 'home'
  action: ->
    @render()
Router.route '/scripts/new',
  name: 'scriptsNew'
  layoutTemplate: 'listLayout'
  action: ->
    @render 'scriptsNew'
    @render('scriptsSidebar', {to: 'sidebar'})
  waitOn: ->
    Meteor.subscribe 'scripts'
Router.route '/scripts/:scriptId',
  name: 'scriptsShow'
  layoutTemplate: 'listLayout'
  action: ->
    @render 'scriptsShow'
    @render('scriptsSidebar', {to: 'sidebar'})
  waitOn: ->
    Meteor.subscribe 'scripts'
    Meteor.subscribe 'bots'
  data: ->
    Scripts.findOne @params.scriptId
Router.route '/scripts',
  name: 'scripts'
  action: ->
    defaultSelectedScriptId = Session.get('lastScriptViewedId') or Scripts.findOne({}, {sort: {createdAt:1}})?._id
    if defaultSelectedScriptId
      Router.go "/scripts/#{defaultSelectedScriptId}", {}, {replaceState: true}
    else
      Router.go "/scripts/new", {}, {replaceState: true}
Router.route '/bots',
  name: 'bots'
  action: ->
    defaultSelectedBotId = Session.get('lastBotViewedId') or Bots.findOne({}, {sort: {createdAt:1}})?._id
    if defaultSelectedBotId
      Router.go "/bots/#{defaultSelectedBotId}", {}, {replaceState: true}
    else
      Router.go "/bots/new", {}, {replaceState: true}

Router.route 'bots/new',
  name: 'botsNew'
  layoutTemplate: 'listLayout'
  action: ->
    @render 'botsNew'
    @render('botsSidebar', {to: 'sidebar'})
  waitOn: ->
    Meteor.subscribe 'bots'
    Meteor.subscribe 'scripts'
  data: ->
    Scripts.find()
Router.route '/bots/:botId',
  name: 'botsShow'
  layoutTemplate: 'listLayout'
  action: ->
    @render 'botsShow'
    @render('botsSidebar', {to: 'sidebar'})
    console.log "Updating session botsShow.botId #{@params.botId}"
    Session.set 'botsShow.botId', @params.botId
  waitOn: ->
    Meteor.subscribe 'bots'
    Meteor.subscribe 'scripts'
    Meteor.subscribe 'sessions', @params.botId
    Meteor.subscribe 'networks'
  data: ->
    Bots.findOne @params.botId
Router.route '/bots/:botId/:section',
  name: 'data'
  layoutTemplate: 'listLayout'
  action: ->
    section = @params.section
    capitalizedSection = section.charAt(0).toUpperCase() + section.slice(1)
    @render 'bot' + capitalizedSection
    @render('botsSidebar', {to: 'sidebar'})
  waitOn: ->
    Meteor.subscribe 'bots'
    Meteor.subscribe 'sessions', @params.botId
    Meteor.subscribe 'networks'

    #switch @params.section
      #when 'settings'
        #Meteor.subscribe 'networkHandles', @params._id
        #Meteor.subscribe 'sessions', @params.botId
      #when 'convos'
        #Meteor.subscribe 'sessions', @params.botId
      #when 'networks'
        #Meteor.subscribe 'networks'
  data: ->
    Bots.findOne @params.botId

# ---
# generated by js2coffee 2.2.0
