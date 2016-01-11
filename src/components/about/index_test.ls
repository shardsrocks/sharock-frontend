require! {
  'lodash': {extend}
  './': view
}
test = it


describe \about, ->
  var _this


  beforeEach ->
    _this := extend view


  test \name, ->
    expect(_this.name).to.equal \about
