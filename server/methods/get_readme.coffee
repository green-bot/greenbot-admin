Meteor.methods
  'getReadme' : (scriptId) ->
    fs = Npm.require('fs')
    script = Scripts.findOne(_id: scriptId)
    # If we didn't find it, return nothing.
    return '' unless script

    fileName =  process.env.PWD +
                '/../greenbot' + script.npm_pkg_location.slice(1)
    fileName += '/README.md'
    bufData = fs.readFileSync  fileName
    strData = bufData.toString()
    return strData
