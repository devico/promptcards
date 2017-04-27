// app/javascript/packs/application.js

import Vue from 'vue'
//import App from '../components/app.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))

  new Vue({
    el: '#vue-cards-form',
    data: function(){
      return {
        form_obj: {
          original_text: '',
          translated_text: '',
          image: '',
          block: ''
        }
      }
    },
    methods: {
      onSubmit: function(event) {
        var self = this;
        this.$http.post('/cards', { cards: self.form_obj })
      }
    }
  });
})
