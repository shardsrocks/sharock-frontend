require! {
  'lodash': {extend}
  './index': view
}
test = it

describe \syncing, ->
  var _this


  beforeEach ->
    _this := extend view, view.data(), view.methods


  test \name, ->
    expect(_this.name).to.equal \syncing
