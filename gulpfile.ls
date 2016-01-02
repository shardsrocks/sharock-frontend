require! {
  child_process: {spawn}

  'prelude-ls': {union}
  'require-clean'

  gulp
  'gulp-util': gutil
  'run-sequence'
}

$ = require('gulp-load-plugins')()


# ----- default ------------------------------------------------------

run-webpack = (opt) ->
  defaults = [
    '--colors'
    '--progress'
    '--display-chunks'
  ]
  opt = union opt, defaults
  spawn 'webpack', opt, stdio: 'inherit'


gulp.task \webpack, [\webpack-preload], ->
  run-webpack []


gulp.task \webpack-watch, [\webpack-preload], ->
  run-webpack ['--watch']


gulp.task \webpack-preload, []


# ----- less ---------------------------------------------------------

gulp.task \less, ->
  gulp.src('src/*.less')
    .pipe $.plumber()
    .pipe $.less()
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

gulp.task \build, [\webpack \build-watch]
gulp.task \build-watch, [\jade \less \assets \dotenv]


# ----- watch --------------------------------------------------------

gulp.task \watch, ->
  run-sequence(
    \build-watch,
    \server,
    [\jade-watch \less-watch \webpack-watch \assets-watch \dotenv-watch]
  )


# ----- default ------------------------------------------------------

gulp.task \default, [\watch]
