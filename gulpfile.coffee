path = require 'path'
gulp = require 'gulp'
stylus  = require 'gulp-stylus'
jade = require 'gulp-jade'
reload = require 'gulp-livereload'
awatch = require 'gulp-autowatch'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
coffeeify = require 'coffeeify'
browserify = require 'browserify'

paths = 
  coffee: './client/**/*.coffee'
  jade: './client/*.jade'
  stylus: './client/css/app.styl'
  public: './public'
  coffeeSrc: './client/router.coffee'

gulp.task 'server', (cb) ->
  require './server'

gulp.task 'coffee', ->
  bCache = {}
  b = browserify paths.coffeeSrc,
    debug: true
    interestGlobals: false
    cache: bCache
    extensions: ['.coffee']
  b.transform coffeeify
  b.bundle()
  .pipe source 'start.js'
  .pipe buffer()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'jade', ->
  gulp.src paths.jade
  .pipe jade()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'stylus', ->
  gulp.src paths.stylus
  .pipe stylus()
  .pipe gulp.dest paths.public
  .pipe reload()

gulp.task 'watch', ->
  awatch gulp, paths

gulp.task 'default', ['coffee', 'jade', 'stylus', 'server', 'watch']