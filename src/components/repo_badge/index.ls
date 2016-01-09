require('./index.less')

module.exports =
  name: \repo-badge
  template: require('./index.jade')()
  props: ['statusBadgeUrl', 'devStatusBadgeUrl']
