Meteor.methods
  'getReadme' : (scriptId) ->
    fs = Npm.require('fs')
    script = Scripts.findOne(_id: scriptId)
    fileName =  process.env.PWD +
                '/../greenbot' + script.npm_pkg_location.slice(1)
    fileName += '/README.md'
    bufData = fs.readFileSync  fileName
    strData = bufData.toString()
    return strData
