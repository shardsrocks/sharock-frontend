require! {
  process: {cwd}
  path: {join}

  gulp
  'gulp-util': gutil
  karma
}


gulp.task \karma, [\dotenv-test], (done) !->
  options =
    configFile: join cwd(), 'karma.conf.js'
    singleRun: true

  on-exit = (exit-code) ->
    gutil.log "Karma has exited with #{exit-code}"
    process.exit(exit-code)

  new karma.Server(options, on-exit).start!
