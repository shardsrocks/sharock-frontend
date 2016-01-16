require! {
  './index.less':{}
  '../../env.json': {API_SERVER_URL}
}

module.exports =
  name: \repo
  template: require('./index.jade')()
  data: ->
    active: false
    timer-id: null
    interval-msec: 3000
    retry-count: 0
    retry-count-max: 10
    syncing: false
    package: null
    package-deps: null
    status-badge-url: null
    dev-status-badge-url: null


  computed:
    path: -> @$route.path
    badge-path: -> "#{@path}/badge"
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
    dev-deps: -> @deps-data.development-dependencies

  methods:
    begin-sync: ->
      clear-interval @timerId if @timer-id
      @timer-id = set-interval @sync.bind(@), @interval-msec
      @sync()

    sync: ->
      @retry-count++
      if @retry-count >= @retry-count-max
        clear-interval @timer-id if @timer-id
        @timer-id = null
        return

      if @timer-id && !@active
        clear-interval @timer-id
        @timer-id = null
        return

      @send-request()

    send-request: ->
      @resource.get().then (res) ~>
        @syncing = !res.data
        if res.data
          clear-interval @timer-id if @timer-id
          @timer-id = null
          @package = res.data.package
          @package-deps = res.data.package_deps
          @status-badge-url = "#{API_SERVER_URL}/#{res.data.status_badge_url}"
          @dev-status-badge-url = "#{API_SERVER_URL}/#{res.data.dev_status_badge_url}"

  route:
    activate: (transition) ->
      @active = true
      @begin-sync()
      transition.next()

    deactivate: (transition) ->
      @active = false
      transition.next()
