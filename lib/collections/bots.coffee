@Bots = new Mongo.Collection('Bots')

BotSchema = new SimpleSchema
  notificationEmails:
    type: String
    optional: false
    label: "Notification Emails"
  ,
  notificationEmailSubject:
    type: String
    optional: false
    label: "Notification Email Subject"
    defaultValue: 'Conversation Complete'
  ,
  postConversationWebhook:
    type: String
    optional: true
    label: "Post Conversation Webhook"
    defaultValue: null
  ,
  accountId:
    type: String
  addresses:
    type: [Object]
    defaultValue: []
    blackbox: true
  description:
    type: String
  name:
    type: String
  scriptId:
    type: String
  settings:
    type: [Object]
    blackbox: true
  ownerHandles:
    type: [Object]
    defaultValue: []

Bots.attachSchema(BotSchema)
