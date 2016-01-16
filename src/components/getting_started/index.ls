require('./index.less')

module.exports =
  name: \getting-started
  template: require('./index.jade')()

  data: ->
    host: 'github'
    owner: null
    repo: null

  computed:
    path: -> "#{@host}/#{@owner}/#{@repo}"

  methods:
    move: -> @$router.go(@path)
