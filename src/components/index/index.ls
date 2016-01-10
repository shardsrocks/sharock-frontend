require('./index.less')

module.exports =
  name: \index
  template: require('./index.jade')()

  data: ->
    resource: @$resource('api/package/recent_updated', { count: 30 })
    recent-updated-packages: []

  route:
    activate: ->
      @resource.get().then (res) ~>
        @recent-updated-packages = res.data
