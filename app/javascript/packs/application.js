// app/javascript/packs/application.js

import Vue from 'vue'

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

  new Vue({
    el: "#flickr-block",
    data: function(){
      return {
        tags: ''
        }
      }
    },
    methods: {
      searchFlickr: function(event) {
        var self = this;
        this.$http.get('/flickrs', { flickrs: self.tags })
      }
    }
          
  });
