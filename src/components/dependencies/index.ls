require('./index.less')

module.exports =
  name: \dependencies
  template: require('./index.jade')()
  ready: ->
    console.log \dependencies
