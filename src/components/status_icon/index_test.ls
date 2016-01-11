require! {
  'lodash': {extend}
  './index': view
}
test = it


describe \status-icon, ->
  var _this


  beforeEach ->
    _this := extend view, view.computed


  test \name, ->
    expect(_this.name).to.equal \status-icon


  describe \computed, ->
    describe \color, ->
      test 'up_to_date', ->
        _this.status = 'up_to_date'
        expect(_this.color()).to.equal '#85D6A1'

      test 'pinned_out_of_date', ->
        _this.status = 'pinned_out_of_date'
        expect(_this.color()).to.equal '#F5EA4E'

      test 'out_of_date', ->
        _this.status = 'out_of_date'
        expect(_this.color()).to.equal '#FF734D'

      test 'otherwise', ->
        _this.status = 'unknown'
        expect(_this.color()).to.equal '#9E9E9E'
