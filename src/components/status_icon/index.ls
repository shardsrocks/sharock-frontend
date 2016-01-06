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
      | "up_to_date" => SUCCESS_COLOR
      | "pinned_out_of_date" => WARNING_COLOR
      | "out_of_date" => ERROR_COLOR
      | otherwise => NORMAL_COLOR
