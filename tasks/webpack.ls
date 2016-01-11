require! {
  process
  child_process: {spawn}

  gulp
  'gulp-util': gutil
  'prelude-ls': {union, join}
}

run-webpack = (opt, prod) ->
  defaults = [
    '--colors'
    '--progress'
    '--display-chunks'
  ]
  opt = union opt, defaults

  message = if opt.length > 0
    "Run webpack with options `#{join ' ' opt}`"
  else
    'Run webpack without options'

  message += ' with optimize' if prod
  gutil.log message

  process.env.WEBPACK_ENV = if prod then 'production' else 'development'
  spawn 'webpack', opt, stdio: 'inherit'


gulp.task \webpack, [\webpack-preload], ->
  run-webpack []


gulp.task \webpack-prod, [\webpack-preload], ->
  run-webpack [], true


gulp.task \webpack-watch, [\webpack-preload], ->
  run-webpack ['--watch']


gulp.task \webpack-preload, [\dotenv]
