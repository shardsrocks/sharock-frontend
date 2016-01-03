require! {
  './index.less':{}
}

module.exports =
  name: \repo
  template: require('./index.jade')()
  data: ->
    package: null
    package-deps: null


  computed:
    path: -> @$route.path
    host: -> @$route.name
    owner: -> @$route.params.owner
    repo: -> @$route.params.repo

    github: -> @host == 'github'
    bitbucket: -> @host == 'bitbucket'

    resource: -> @$resource("package/#{@host}/#{@owner}/#{@repo}")

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


  route:
    activate: ->
      @resource.get().then (res) ->
        console.log @
        console.log res
        @package = res.data.package
        @package-deps = res.data.package_deps

