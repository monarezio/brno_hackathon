import loginComponent from '../components/login.vue'
import homepageComponent from '../components/homepage.vue'
import contactComponent from '../components/contact.vue'
import aboutComponent from '../components/about.vue'
import dashboardComponent from '../components/dashboard.vue'

export const routes = [
  {
    path: '/',
    component: homepageComponent
  },
  {
    path: '/login',
    component: loginComponent
  },
  {
    path: '/about',
    component: aboutComponent
  },
  {
    path: '/contact',
    component: contactComponent
  },
  {
    path: '/dashboard',
    component: dashboardComponent
  }
];
