import { createRouter, createWebHistory } from 'vue-router'
import Homepage from '../components/Homepage.vue'

// Import views (lazy-loading AboutMe for performance)
const AboutMe = () => import('../components/AboutMe.vue')
const Projects = () => import('../components/Projects.vue')
const Contact  = () => import('../components/Contact.vue')

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Homepage
    },
    {
      path: '/about',
      name: 'about',
      component: AboutMe
    },
    {
      path: '/projects',
      name: 'projects',
      component: Projects
    },
    {
      path: '/contact',
      name: 'contact',
      component: Contact
    }
  ],
  // Optional: Add scroll behavior to ensure we start at the top on navigation
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  }
})

export default router
