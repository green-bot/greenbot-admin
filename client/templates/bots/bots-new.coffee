Template.botsNew.helpers(
  scripts: -> Scripts.find( {}, sort: { name:1} )
)
