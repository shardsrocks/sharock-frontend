require! {
  vue: Vue
  'vue-router': VueRouter
  './config/api': api
}

Vue.use(VueRouter)
Vue.use(require('vue-resource'))

# for vue-resource
Vue.http.options.root = api.endpoint

# load all components
require('./components')

# create my entry point
App = Vue.extend()

# start my app
router = require('./routes')()
router.start(App, 'body')
