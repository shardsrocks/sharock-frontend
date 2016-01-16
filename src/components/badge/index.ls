require! {
  './index.less': {}
  '../../config/static': static-conf
  '../../config/api': api-conf
}


module.exports =
  name: \badge
  template: require('./index.jade')!

  computed:
    has-info: -> @$route.params.owner && @$route.params.repo
    host: -> 'github'
    owner: -> @$route.params.owner || '<your-github-name>'
    repo: -> @$route.params.repo || '<your-repository-name>'

    status-badge-url: ->
      if @has-info
        "#{api-conf.endpoint}/badge/#{@host}/#{@owner}/#{@repo}/status.svg"
      else
        "#{static-conf.endpoint}/assets/img/status/up_to_date.svg"

    dev-status-badge-url: ->
      if @has-info
        "#{api-conf.endpoint}/badge/#{@host}/#{@owner}/#{@repo}/dev_status.svg"
      else
        "#{static-conf.endpoint}/assets/img/status/dev-up_to_date.svg"

