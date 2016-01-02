require('./index.less')

module.exports =
  name: \about
  template: require('./index.jade')()
  ready: ->
    console.log \about

