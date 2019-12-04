import Vue from "vue";
import Router from "./router/router";
import Header from "./components/Header.vue";

document.addEventListener("turbolinks:load", () => {
  new Vue({
    el: '#app',
    router: Router,
    components: {
      navbar: Header
    }
  })
})