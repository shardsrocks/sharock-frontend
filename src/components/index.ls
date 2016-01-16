require! {
  vue: Vue
}

Vue.component 'sharock-dependencies', require('./dependencies')
Vue.component 'sharock-deps-summary', require('./deps_summary')
Vue.component 'sharock-footer', require('./footer')
Vue.component 'sharock-header', require('./header')
Vue.component 'sharock-main', require('./main')
Vue.component 'sharock-link', require('./link')
Vue.component 'sharock-recent-updated', require('./recent_updated')
Vue.component 'sharock-repo-badge', require('./repo_badge')
Vue.component 'sharock-repo-header', require('./repo_header')
Vue.component 'sharock-status-icon', require('./status_icon')
Vue.component 'sharock-syncing', require('./syncing')
