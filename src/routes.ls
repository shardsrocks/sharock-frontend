require! {
  vue: Vue
  'vue-router': VueRouter
}

module.exports = ->
  Foo = Vue.extend()

  router = new VueRouter()
  router.map(
    '/': {
      component: Foo
    }
  )

  router
