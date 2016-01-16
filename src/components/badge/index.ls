require! {
  './index.less': {}
  '../../config/static': {endpoint}
}


module.exports =
  name: \badge
  template: require('./index.jade')!

  data: ->
    status-badge-url: "#{endpoint}/assets/img/status/up_to_date.svg"
    dev-status-badge-url: "#{endpoint}/assets/img/status/dev-up_to_date.svg"

  computed:
    host: -> @$route.name || 'github'
    owner: -> @$route.params.owner || '<your-github-name>'
    repo: -> @$route.params.repo || '<your-repository-name>'
