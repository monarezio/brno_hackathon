import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router';
import VueCookie from 'vue-cookie'

Vue.use(VueRouter);
Vue.use(VueCookie);

import {routes} from './router/routes.js'

const router = new VueRouter({
  mode: 'history',
  routes: routes
});

new Vue({
  el: '#app',
  router,
  render: h => h(App)
});
