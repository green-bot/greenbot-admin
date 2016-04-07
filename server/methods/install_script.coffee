Fs = Npm.require('fs')
Chokidar = Npm.require('chokidar')
Fiber = Npm.require('fibers')

Meteor.methods({
  installScript: (pkg) ->
    Exec = Npm.require('child_process').exec
    Future = Npm.require("fibers/future")

    # We can do other things now...
    this.unblock()
    console.log "Adding #{pkg}"
    cmd = "npm install #{pkg} -g"
    future = new Future()
    Exec cmd, (err, stdout, stderr) ->
      if err
        console.log(err)
        throw new Meteor.Error(500, "#{cmd} failed")
      future.return "Installed"
    future.wait()

  removeScript: (pkg) ->
    Exec = Npm.require('child_process').exec
    Future = Npm.require("fibers/future")

    # We can do other things now...
    this.unblock()
    console.log "Removing #{pkg}"
    cmd = "npm uninstall #{pkg} -g"
    future = new Future()
    Exec cmd, (err, stdout, stderr) ->
      if err
        console.log(err)
        throw new Meteor.Error(500, "#{cmd} failed")
      future.return "Removed"
    future.wait()
})

removeScript = (pkg) ->
  console.log "removeScript: Removing #{pkg} from scripts"
  removedCount = Scripts.remove {npm_pkg_name: pkg}
  console.log "Removed #{removedCount} documents"

addOrUpdateScript = (pkg, path) ->
  console.log "addScript: Adding or updating #{pkg} to scripts"
  if Scripts.find({npm_pkg_name: pkg}).count() > 0
    changeScript(pkg, path)
    return

  script = JSON.parse(Fs.readFileSync(path + "/bot.json"))
  script = script[0]
  script.npm_pkg_name = pkg
  script.npm_pkg_location = path
  script.default_cmd = 'npm start --loglevel silent'
  script.default_path = path
  console.log "Creating #{pkg}"
  Scripts.insert script

changeScript = (pkg, path) ->
  console.log "Updating #{pkg}"
  script = JSON.parse(Fs.readFileSync(path + "/bot.json")).shift()
  Scripts.update({npm_pkg_name: pkg}, {$set: script})


options =
  cwd: Meteor.settings.NPM_GLOBAL_PATH

Chokidar.watch('*/bot.json', options)
.on 'add', Meteor.bindEnvironment (path) ->
  pkg = path.split('/').shift()
  console.log "Add #{pkg} to scripts"
  addOrUpdateScript pkg, Meteor.settings.NPM_GLOBAL_PATH + "/" + pkg
.on 'unlink', Meteor.bindEnvironment (path) ->
  pkg = path.split('/').shift()
  console.log "Remove #{pkg} from scripts"
  removeScript pkg
.on 'change', Meteor.bindEnvironment (path) ->
  pkg = path.split('/').shift()
  console.log "Update #{pkg} in scripts"
  changeScript pkg, Meteor.settings.NPM_GLOBAL_PATH + "/" + pkg
