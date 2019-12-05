import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesConmponent from '../components/ArticlesConmponent.vue'
import RegisterConmponent from "../components/RegisterConmponent.vue";


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: "/", component: ArticlesConmponent },
    { path: "/sign_up", component: RegisterConmponent }
  ]
})