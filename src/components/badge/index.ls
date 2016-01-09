require! {
  '../../env.json': {STATIC_SERVER_URL}
}

require('./index.less')

module.exports =
  name: \badge
  template: require('./index.jade')()

  data: ->
    status-badge-url: "#{STATIC_SERVER_URL}/assets/img/status/up_to_date.svg"
    dev-status-badge-url: "#{STATIC_SERVER_URL}/assets/img/status/dev-up_to_date.svg"
