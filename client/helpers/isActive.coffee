Template.registerHelper 'isActive', (view) ->
  if !(view instanceof Spacebars.kw)
    throw new Error('isActive options must be key value pair such ' + 'as {{isActive route=\'home\'}}. You passed: ' + JSON.stringify(view))
 
  options = view and view.hash or {}
  className = options.className or ''
  regex = options.regex or false
  inverse = options.inverse or false
  route = options.route or ''
  path = options.path or ''
  data = _.extend({}, options.data or this)
 
  check className, Match.Optional(String)
  check regex, Match.Optional(Boolean)
  check inverse, Match.Optional(Boolean)
  check route, Match.Optional(String)
  check path, Match.Optional(String)
  check data, Match.Optional(Object)
 
  if _.isEmpty(className)
    className = if inverse then 'disabled' else 'active'

  if _.isEmpty(route) and _.isEmpty(path)
    throw new Error('isActive requires a route or path to be specified, such ' + 'as {{isActive route=\'home\'}}. You passed: ' + JSON.stringify(view))
 
  controller = Router.current()
 
  if !controller
    return false
  current = undefined
  pattern = undefined
 
  if route
    if !controller.route
      return false
    current = controller.route.getName()
    pattern = route
  else
    current = controller.location.get().path
    pattern = path
  test = false
 
  if regex
    re = new RegExp(pattern, 'i')
    test = re.test(current)
  else
    test = current == pattern
 
  if !_.isEmpty(data) and controller.route and test
    _.each controller.route.handler.compiledUrl.keys, (keyConfig) ->
      key = keyConfig.name
      if _.has(data, key)
        if test
          test = data[key] == controller.params[key]
      return
 
  if !inverse and test or inverse and !test
    className
  else
    false