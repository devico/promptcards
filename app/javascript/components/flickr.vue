<template>
  <div>
    <input type="text" v-model="tag">  
    <button type="submit" v-on:click.prevent="searchFlickr">Найти во Flickr</button>         
  </div>  
</template>

<script>
  const el = '#flickr'

  function data() {
    return {
      tag: ''
    }
  }

  function searchFlickr() { 
    console.log('help me')
  }

  export default {
    el, data,
    methods: {
      searchFlickr
    }
  }
</script>
