require! {
  vue: Vue
  'vue-router': VueRouter
}

Vue.use(VueRouter)

# load all components
require('./components')

# create my entry point
App = Vue.extend()

# start my app
router = require('./routes')()
router.start(App, 'body')
