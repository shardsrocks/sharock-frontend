require! {
  './index.less':{}
  '../../env.json': {API_SERVER_URL}
}

module.exports =
  name: \repo
  template: require('./index.jade')()
  data: ->
    syncing: false
    package: null
    package-deps: null
    status-badge-url: null
    dev-status-badge-url: null


  computed:
    path: -> @$route.path
    host: -> @$route.name
    owner: -> @$route.params.owner
    repo: -> @$route.params.repo

    github: -> @host == 'github'
    bitbucket: -> @host == 'bitbucket'

    resource: -> @$resource("api/package/#{@host}/#{@owner}/#{@repo}")

    deps-data: ->
      try
        JSON.parse(@package-deps.deps_data)
      catch e
        {}

    status: -> @package-deps.status
    dev-status: -> @package-deps.dev_status
    deps: -> @deps-data.dependencies
    dev-deps: -> @deps-data.developmentDependencies

  route:
    activate: ->
      @resource.get().then (res) ~>
        console.log res.data
        @syncing = !res.data
        if res.data
          @package = res.data.package
          @package-deps = res.data.package_deps
          @status-badge-url = "#{API_SERVER_URL}/#{res.data.status_badge_url}"
          @dev-status-badge-url = "#{API_SERVER_URL}/#{res.data.dev_status_badge_url}"

