require('./index.less')

module.exports =
  name: \index
  template: require('./index.jade')()
  ready: ->
    console.log \index
