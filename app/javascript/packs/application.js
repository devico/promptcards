// app/javascript/packs/application.js
'use strict'

import Vue from 'vue'
import VueResource from 'vue-resource'

//

document.addEventListener("DOMContentLoaded", function() {

  Vue.use(VueResource)
  
  new Vue({
    el: '#flickr-block',    
    data: {
      tag: ''
    },
    methods: {
      searchFlickr: function() {
        console.log('help me!')
        // let self = this;
        // this.$http.get('/flickrs', { flickrs: self.tag })
      }
    }   
  });
});
