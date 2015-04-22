conf =
  dest: [
    _site : [
      'js/'
      'css/'
      'html/'
      'index.html'
    ]
    _conf : [
      'nginx.conf'
      'mime.types'
    ]
    _logs : [
      'nginx.error.logs'
    ]
  ]
  src: [
    site: [
      'scripts/'
      'styles'
      'html/'
      'layouts/'
      'partials/'
      'mixins/'
    ]
    data: [
      posts: [

      ]
    ]
    nginx: [
      'nginx.conf.ejs'
      'mime.types'
    ]
  ]