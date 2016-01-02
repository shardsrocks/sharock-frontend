require! {
  child_process: {spawn}

  'prelude-ls': {union}

  gulp
  'gulp-util': gutil
  'run-sequence'
}

$ = require('gulp-load-plugins')()


# ----- default ------------------------------------------------------

runWebpack = (opt) ->
  defaults = [
    '--colors'
    '--progress'
    '--display-chunks'
  ]
  opt = union opt, defaults
  spawn 'webpack', opt, stdio: 'inherit'


gulp.task \webpack, [\webpack-preload], ->
  runWebpack []


gulp.task \webpack-watch, [\webpack-preload], ->
  runWebpack ['--watch']


gulp.task \webpack-preload, []


# ----- server -------------------------------------------------------

gulp.task \server, ->
  port = 8080
  gutil.log "Listening: http://0.0.0.0:#{port}"

  gulp.src('dist')
    .pipe $.server-livereload(
      livereload: true
      directory-listing: false
      open: false
      host: '0.0.0.0'
      port: port
    )


# ----- watch --------------------------------------------------------

gulp.task \watch, ->
  run-sequence(
    \server,
    \webpack-watch
  )


# ----- build --------------------------------------------------------

gulp.task \build, [\webpack]


# ----- default ------------------------------------------------------

gulp.task \default, [\watch]
