require! {
  'lodash': {extend}
  './': view
}
test = it


describe \footer, ->
  var _this


  beforeEach ->
    _this := extend view


  test \name, ->
    expect(_this.name).to.equal \footer
