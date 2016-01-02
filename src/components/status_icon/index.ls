require('./index.less')

NORMAL_COLOR  = '#9E9E9E'
SUCCESS_COLOR = '#85D6A1'
WARNING_COLOR = '#F5EA4E'
ERROR_COLOR   = '#FF734D'

module.exports =
  name: 'status-icon'
  props: ['status']
  template: require('./index.jade')()

  computed:
    color: ->
      switch @status
      | "success" => SUCCESS_COLOR
      | "warning" => WARNING_COLOR
      | "error"   => ERROR_COLOR
      | otherwise => NORMAL_COLOR
