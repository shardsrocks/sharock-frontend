require! {
  child_process: {spawn}

  'prelude-ls': {union}
  'require-clean'

  gulp
  'gulp-util': gutil
  'run-sequence'
}

$ = require('gulp-load-plugins')()


# ----- webpack ------------------------------------------------------

run-webpack = (opt, prod) ->
  defaults = [
    '--colors'
    '--progress'
    '--display-chunks'
  ]
  opt = union opt, defaults


  message = if opt.length > 0
    "Run webpack with options `#{opt.join(' ')}`"
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


gulp.task \webpack-preload, []


# ----- less ---------------------------------------------------------

run-less = (prod) ->
  gulp.src('src/*.less')
    .pipe $.plumber()
    .pipe $.less()
    .pipe $.if(prod, $.cssnano())


gulp.task \less, ->
  run-less()
    .pipe gulp.dest('dist')


gulp.task \less-prod, ->
  run-less(true)
    .pipe gulp.dest('dist')


gulp.task \less-watch, ->
  gulp.watch 'src/*.less', [\less]


# ----- jade ---------------------------------------------------------

gulp.task \jade, [\dotenv], ->
  gulp.src('src/*.jade')
    .pipe $.plumber()
    .pipe $.jade(locals: require-clean('./src/env.json'))
    .pipe gulp.dest('dist')


gulp.task \jade-watch, ->
  gulp.watch 'src/*.jade', [\jade]


# ----- assets -------------------------------------------------------

gulp.task \assets, ->
  gulp.src('assets/**/*')
    .pipe gulp.dest('dist/assets')


gulp.task \assets-watch, ->
  gulp.watch 'assets/**/*', [\assets]


# ----- dotenv -------------------------------------------------------

gulp.task \dotenv, ->
  gulp.src('.env')
    .pipe $.dotenv()
    .pipe $.rename('env.json')
    .pipe gulp.dest('src/')


gulp.task \dotenv-watch, ->
  gulp.watch '.env', [\dotenv \jade]


# ----- server -------------------------------------------------------

gulp.task \server, ->
  spawn './bin/server', [], stdio: 'inherit'


# ----- build --------------------------------------------------------

gulp.task \build, [\webpack \build-without-webpack]
gulp.task \build-prod, [\webpack-prod \build-prod-without-webpack]
gulp.task \build-without-webpack, [\jade \less \assets \dotenv]
gulp.task \build-prod-without-webpack, [\jade \less-prod \assets \dotenv]


# ----- watch --------------------------------------------------------

gulp.task \watch, ->
  run-sequence(
    \build-without-webpack,
    \server,
    [\jade-watch \less-watch \webpack-watch \assets-watch \dotenv-watch]
  )


# ----- default ------------------------------------------------------

gulp.task \default, [\watch]
