require! {
  'lodash': {extend}
  './': view
}
test = it


describe \badge, ->
  var _this


  beforeEach ->
    _this := extend view, view.computed


  test \name, ->
    expect(_this.name).to.equal \badge


  describe \computed, ->
    describe \status-badge-url, ->
      test 'has info', ->
        _this.has-info = true
        _this.host = 'host'
        _this.owner = 'owner'
        _this.repo = 'repo'
        expect(_this.status-badge-url!).to.equal('//api/badge/host/owner/repo/status.svg')

      test 'no info', ->
        _this.has-info = false
        expect(_this.status-badge-url!).to.equal('//static/assets/img/status/up_to_date.svg')

    describe \dev-status-badge-url, ->
      test 'has info', ->
        _this.has-info = true
        _this.host = 'host'
        _this.owner = 'owner'
        _this.repo = 'repo'
        expect(_this.dev-status-badge-url!).to.equal('//api/badge/host/owner/repo/dev_status.svg')

      test 'no info', ->
        _this.has-info = false
        expect(_this.dev-status-badge-url!).to.equal '//static/assets/img/status/dev-up_to_date.svg'

