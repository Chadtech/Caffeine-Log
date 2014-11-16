fission = require './app'
homeView = require './pages/home/home.View'
loginView = require './pages/login/login.View'

router = fission.router

router.route '/',
  title: 'Home'
  view: homeView
  el: 'content'

router.route '/login',
  title: 'Login'
  view: loginView
  el: 'content'

router.route '/profile',
  title: 'Profile'
  el: 'content'

router.start()