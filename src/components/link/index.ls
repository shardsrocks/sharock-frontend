require! {
  './index.less': {}
  '../../config/static': {endpoint}
}

module.exports =
  name: \repo-header
  template: require('./index.jade')()
  props: ['host', 'owner', 'repo']

  computed:
    github: -> @host == 'github'
    bitbucket: -> @host == 'bitbucket'

    sharock-link: ->
      "#{endpoint}/#{@host}/#{@owner}/#{@repo}"

    repo-link: ->
      if @github
        "https://github.com/#{@owner}/#{@repo}"
      else if @bitbucket
        "https://bitbucket.org/#{@owner}/#{@repo}"

