require! {
  '../../env.json': {STATIC_SERVER_URL}
}

require('./index.less')

module.exports =
  name: \syncing
  template: require('./index.jade')()
  props:
    enabled:
      type: Boolean
      default: true

  data: ->
    style:
      background-image: "url(\"#{STATIC_SERVER_URL}/assets/img/loading.gif\")"
