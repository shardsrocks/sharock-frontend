require! {
  vue: Vue
  'vue-router': VueRouter
}

Vue.use(VueRouter)

App = Vue.extend(
  components:
    'sharock-main': require('./components/main')
)

router = require('./routes')()
router.start(App, 'body')
