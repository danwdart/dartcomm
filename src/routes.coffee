String::toCamel = ->
  @replace /(^[a-z]|\-[a-z])/g, ($1) ->
    $1.toUpperCase().replace "-", ""

module.exports = (app) ->
  
  # simple session authorization
  checkAuth = (req, res, next) ->
    unless req.session.authorized
      res.statusCode = 401
      res.render '401', 401
    else
      next()
  
  app.all '/', (req, res, next) ->
    routeMvc('index', 'index', req, res, next)

  app.all '/:controller', (req, res, next) ->
    routeMvc(req.params.controller, 'index', req, res, next)

  app.all '/:controller/:method', (req, res, next) ->
    routeMvc(req.params.controller, req.params.method, req, res, next)

  app.all '/:controller/:method/:id', (req, res, next) ->
    routeMvc(req.params.controller, req.params.method + '_' + req.params.id, req, res, next)

  app.all '/*', (req, res) ->
    console.warn "error 404: ", req.url
    res.statusCode = 404
    res.render '404', 404

routeMvc = (controllerName, methodName, req, res, next) ->

  process.on 'uncaughtException', (err) ->
    console.log 'Caught exception: ' + err
    res.send 'Caught exception: ' + err
    res.statusCode = 500

  methodName = methodName.toLowerCase()
  methodName = req.method.toLowerCase() + methodName.toCamel();
  controllerName = 'index' if not controllerName?
  controller = null
  try
    controller = require "./controllers/" + controllerName
  catch e
    console.warn "controller not found: " + controllerName, e
    next()
    return
  data = null
  if typeof controller[methodName] is 'function'
    actionMethod = controller[methodName].bind controller
    actionMethod req, res, next
  else
    console.warn 'method not found: ' + methodName
    next()