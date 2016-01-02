require! {
  'vue-router': VueRouter
}

module.exports = ->
  router = new VueRouter(
    hashbang: false
    history: true
  )

  router.map(
    '/':
      component: require('./components/index/index')
    '/about':
      component: require('./components/about')
    '/github/:owner/:repo':
      name: 'github'
      component: require('./components/repo')
    '/bitbucket/:owner/:repo':
      name: 'bitbucket'
      component: require('./components/repo')
  )

  router
