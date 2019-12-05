import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesConmponent from '../components/ArticlesConmponent.vue'

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: ArticlesConmponent },
  ],
})