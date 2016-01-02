require('./index.less')

module.exports =
  name: \repo
  template: require('./index.jade')()
  ready: ->
    console.log "repo ready"

  computed:
    path: -> @$route.path
    host: -> @$route.name
    owner: -> @$route.params.owner
    repo: -> @$route.params.repo

    github: -> @host == 'github'
    bitbucket: -> @host == 'bitbucket'

    host-link: ->
      if @github
        "https://github.com/"
      else if @bitbucket
        "https://bitbucket.org/"

    owner-link: ->
      if @github
        "https://github.com/#{@owner}"
      else if @bitbucket
        "https://bitbucket.org/#{@owner}/"

    repo-link: ->
      if @github
        "https://github.com/#{@owner}/#{@repo}"
      else if @bitbucket
        "https://bitbucket.org/#{@owner}/#{@repo}"
