// app/javascript/packs/application.js
'use strict'

import Vue from 'vue'
import VueResource from 'vue-resource'
import flickr from '../components/flickr.vue'

document.addEventListener("DOMContentLoaded", () => {
  Vue.use(VueResource)

  new Vue(flickr)

});
