require! {
  lodash: {size}
}

require('./index.less')

module.exports =
  name: \dependencies
  template: require('./index.jade')()
  props: ['deps']

  computed:
    isEmpty: -> size @deps |> (== 0)
