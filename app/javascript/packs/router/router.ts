import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import ArticlesComponent from "../components/ArticlesComponent.vue"
import RegisterComponent from "../components/RegisterComponent.vue";
import LoginComponent from "../components/LoginComponent.vue";


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: "/", component: ArticlesComponent },
    { path: "/sign_up", component: RegisterComponent },
    { path: "/sign_in", component: LoginComponent }
  ]
})