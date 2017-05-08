<template>
  <div>
    <input type="text" v-model="tag">  
    <button type="submit" v-on:click.prevent="searchFlickr">Найти во Flickr</button>
    <picture v-for="image in images" :key = 'image' :image='image' @selectedImage="remoteImageForCard"></picture>
    <div class="input hidden card_remote_image_url">
       <input type="hidden" name="remote_image_url" v-model="selectedImage"/>
     </div>
  </div>
</template>

<script>

  import picture from '../components/picture.vue'

  const el = '#flickr'

  function data() {
    return {
      tag: '',
      images: [],
      selectedImage: ''
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
      searchFlickr,
      remoteImageForCard (value) {
        //console.log(value) // someValue
        this.selectedImage = value
      }
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
