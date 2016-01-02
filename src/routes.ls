require! {
  vue: Vue
  'vue-router': VueRouter
}

module.exports = ->
  Foo = Vue.extend()

  router = new VueRouter(
    hashbang: false
    history: true
  )

  router.map(
    '/': {
      component: Foo
    }
  )

  router
