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

// Initialize Firebase
const config = {
	apiKey: "AIzaSyDX19wtQEpULBLgxnisPqN7iFUF8TTvhP0",
	authDomain: "smart-trash-78dcb.firebaseapp.com",
	databaseURL: "https://smart-trash-78dcb.firebaseio.com",
	projectId: "smart-trash-78dcb",
	storageBucket: "smart-trash-78dcb.appspot.com",
	messagingSenderId: "104734177472"
};
firebase.initializeApp(config);

new Vue({
  el: '#app',
  router,
  render: h => h(App)
});
