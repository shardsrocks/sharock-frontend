require! {
  'lodash': {extend}
  './index': view
}
test = it


describe \link, ->
  var _this


  beforeEach ->
    _this := extend view, view.computed


  test \name, ->
    expect(_this.name).to.equal \link


  describe \computed, ->
    describe \github, ->
      test \true, ->
        _this.host = 'github'
        expect(_this.github()).to.be.true

      test \false, ->
        _this.host = 'bitbucket'
        expect(_this.github()).to.be.false


    describe \bitbucket, ->
      test \true, ->
        _this.host = 'bitbucket'
        expect(_this.bitbucket()).to.be.true

      test \false, ->
        _this.host = 'github'
        expect(_this.bitbucket()).to.be.false


    describe \repo-link, ->
      test \github, ->
        _this.github = true
        _this.bitbucket = false
        _this.owner = 'owner'
        _this.repo = 'repo'
        expect(_this.repo-link()).to.equal('https://github.com/owner/repo')

      test \bitbucket, ->
        _this.github = false
        _this.bitbucket = true
        _this.owner = 'owner'
        _this.repo = 'repo'
        expect(_this.repo-link()).to.equal('https://bitbucket.org/owner/repo')
