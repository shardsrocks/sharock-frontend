require! {
  moment
  gulp
  'gulp-symlink': symlink
}


gulp.task \deploy-local, (done) !->
  version = moment().format('YYYYMMDD_HHmmssSSS')
  dir = "./versions/#{version}"

  gulp.src('dist/**/*')
    .pipe(gulp.dest(dir))
    .on 'end', (err) ->
      return done(err) if err

      gulp.src(dir)
        .pipe(symlink('current', force: yes))
        .on 'data', -> done!
        .on 'error', -> done(it)
