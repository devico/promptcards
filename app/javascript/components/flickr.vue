<template>
  <div>
    <input type="text" v-model="tag">  
    <button type="submit" v-on:click.prevent="searchFlickr">Найти во Flickr</button>
    <picture v-bind:images></picture>
  </div>
</template>

<script>

  import picture from '../components/picture.vue'

  const el = '#flickr'

  function data() {
    return {
      tag: '',
      images: []
    }
  }

  function searchFlickr() {

    console.log(this.tag)

    this.$http.get('/flickrs?tags=' + this.tag).then(response => {
      this.images = response.body;
    }, error => {
      console.log(error)
    })
  }

  export default {
    el, data,
    methods: {
      searchFlickr
    },
    components: { 
      picture 
    },
    http: {
      headers: {
        Accept: 'application/json'
      }
    }
  }
</script>
