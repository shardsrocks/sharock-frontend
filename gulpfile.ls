require! {
  fs
  child_process: {spawn}

  'prelude-ls': {union}
  'require-clean'
  'require-dir'

  gulp
  'gulp-util': gutil
  'run-sequence'
}

$ = require('gulp-load-plugins')!
require-dir('./tasks')

# ----- bootstrap ----------------------------------------------------

console.error('[INFO] Checking `.env` file')
fs.statSync('.env')


# ----- webpack ------------------------------------------------------



# ----- less ---------------------------------------------------------

run-less = (prod) ->
  gulp.src('src/*.less')
    .pipe $.plumber!
    .pipe $.less!
    .pipe $.if(prod, $.cssnano!)


gulp.task \less, ->
  run-less!
    .pipe gulp.dest('dist')


gulp.task \less-prod, ->
  run-less(true)
    .pipe gulp.dest('dist')


gulp.task \less-watch, ->
  gulp.watch 'src/*.less', [\less]


# ----- jade ---------------------------------------------------------

gulp.task \jade, [\dotenv], ->
  gulp.src('src/*.jade')
    .pipe $.plumber!
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

runDotenv = ->
  gulp.src(it)
    .pipe $.dotenv!
    .pipe $.rename('env.json')
    .pipe gulp.dest('src/')


gulp.task \dotenv, ->
  runDotenv('.env')


gulp.task \dotenv-test, ->
  runDotenv('.env.test')


gulp.task \dotenv-watch, ->
  gulp.watch '.env', [\dotenv \webpack \jade]


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


# ----- test ---------------------------------------------------------

gulp.task \test, [\karma]


# ----- default ------------------------------------------------------

gulp.task \default, [\watch]
