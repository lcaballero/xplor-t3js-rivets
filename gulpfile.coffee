gulp      = require('gulp')
plugins   = require('gulp-load-plugins')()
stylus    = require('gulp-stylus')
jade      = require('gulp-jade')
data      = require('gulp-data')
tap       = require('gulp-tap')
rename    = require('gulp-rename')
run       = require('gulp-run')
merge     = require('merge2')
del       = require('del')
path      = require('path')
_         = require('lodash')
dest      = gulp.dest
from      = (p) -> { cwdbase: true, cwd: path.join('./src/site/', p) }
to        = (p) -> dest(path.join('./dest/_site', p))
fromBower = (p) -> { cwd: path.join('./bower_components/', p), cwdbase: true }


gulp.task 'build', ['build:jade', 'build:assets', 'build:nginx'], ->

gulp.task 'build:assets', ['build:jade'], ->
  merge(
    gulp.src('**/*.coffee'  , from('scripts')).pipe(plugins.coffee()).pipe(to('js'))
    gulp.src('**/*.styl'    , from('styles')).pipe(stylus()).pipe(to('css'))
    gulp.src('**/*.html'    , from('html')).pipe(to('html'))
    gulp.src('**/*.css'     , from('.')).pipe(to('/css'))

    gulp.src('jquery.js'        , fromBower('jquery/dist')).pipe(to('js/libs'))
    gulp.src('lodash.js'        , fromBower('lodash/dist')).pipe(to('js/libs'))
    gulp.src('Scheming.js'      , fromBower('scheming/dest')).pipe(to('js/libs'))
    gulp.src('Scheming.js.map'  , fromBower('scheming/dest')).pipe(to('js/libs'))
    gulp.src('rivets.js'        , fromBower('rivets/dist')).pipe(to('js/libs'))
    gulp.src('sightglass.js'    , fromBower('sightglass/dist')).pipe(to('js/libs'))

    gulp.src('**/*.js'      , from('scripts')).pipe(to('js'))
  )


gulp.task 'build:jade', ->
  gulp.src('**/*.jade', from('html'))
    .pipe(data((file) ->
      require('./src/data/file-changes.coffee')))
    .pipe(jade({ pretty: true }))
    .pipe(dest('./dest/_site/'))


gulp.task 'build:nginx:logsdir', (cb) ->
  run('mkdir -p ./dest/_logs').exec(cb) # Directory must exist prior to nginx start

gulp.task 'build:nginx', ['build:nginx:logsdir'], ->
  merge(
    gulp.src('nginx.conf.ejs', { cwd: './src/nginx', cwdbase: true})
      .pipe(tap(
        (file) ->
          opts =
            error_log : path.resolve('.', 'dest/_logs/nginx.error.logs')
            app_root  : path.resolve('.', 'dest/_site')
          conf = _.template(file.contents.toString())(opts)
          file.contents = new Buffer(conf)))
      .pipe(rename('nginx.conf'))
      .pipe(dest 'dest/_conf')

    gulp.src('./src/nginx/mime.types').pipe(dest('./dest/_conf'))
    gulp.src('./src/nginx/nginx.error.logs').pipe(dest('./dest/_conf'))
  )


gulp.task 'watch', ->
  ext = 'coffee styl js html jade css'.split(' ')
  exts = ("src/**/*.#{e}" for e in ext)
  gulp.watch(exts, ['build:assets'])


gulp.task 'clean', (cb) -> del('dest', cb)
gulp.task 'open', (cb) -> run('open http://localhost:8080').exec(cb)


gulp.task 'super-clean', ['clean'], (cb) ->
  del('bower_components')
  del('node_modules')


gulp.task 'server', (cb) ->
  conf = path.resolve(process.cwd(), 'dest/_conf/nginx.conf')
  run("nginx -c #{conf}").exec((err, res) ->
    if err?
      console.log(err)
    console.log(res)
    cb(err, res)
  )


gulp.task 'default', ['build:assets', 'watch'], ->
