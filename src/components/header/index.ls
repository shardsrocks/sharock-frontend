require('./index.less')

module.exports =
  name: \header
  template: require('./index.jade')()
  ready: ->
    console.log \header
