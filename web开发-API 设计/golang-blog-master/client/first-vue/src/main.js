// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueResource from 'vue-resource'
import VueCookies from 'vue-cookies' 
import App from './App'
import router from './'

Vue.use(VueResource)
Vue.use(VueCookies)
Vue.config.productionTip = false
Vue.http.options.emulateJSON = true;

Vue.http.interceptors.push((request, next)=>{
    var jwtToken = $cookies.get("LogInUser");
    //console.log("req: ", jwtToken);
    if(jwtToken != "guest"){
      request.headers.set("Authorization", 'Bearer ' + $cookies.get("LogInUser"));
    }
    next((response)=>{
      return response;
    });
});
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
