require('./index.less')

module.exports =
  name: \main
  template: require('./index.jade')()
  ready: ->
    console.log \ready
