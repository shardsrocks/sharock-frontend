require! {
  './index.less':{}
}

module.exports =
  name: \repo
  template: require('./index.jade')()
  data: ->
    syncing: false
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

    deps-data: ->
      try
        JSON.parse(@package-deps.deps_data)
      catch e
        {}

    status: -> @package-deps.status
    dev-status: -> @package-deps.dev_status
    deps: -> @deps-data.dependencies
    dev-deps: -> @deps-data.developmentDependencies

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
      @resource.get().then (res) ~>
        console.log res.data
        @syncing = !res.data
        if res.data
          @package = res.data.package
          @package-deps = res.data.package_deps

