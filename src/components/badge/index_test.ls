require! {
  'lodash': {extend}
  './': view
}
test = it


describe \badge, ->
  var _this


  beforeEach ->
    _this := extend view, view.data()


  test \name, ->
    expect(_this.name).to.equal \badge


  describe \data, ->
    test \status-badge-url, ->
      expect(_this.status-badge-url).to.equal '//static/assets/img/status/up_to_date.svg'

    test \dev-status-badge-url, ->
      expect(_this.dev-status-badge-url).to.equal '//static/assets/img/status/dev-up_to_date.svg'
