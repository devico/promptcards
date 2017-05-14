<template>
  <div>
    <img :src="image" @click="selectImage"/>
  </div>
</template>

<script>

  export default {
    props: ['image'],
    methods: {
      selectImage: function () {
        //console.log('has been selected ' + this.image)
        this.$emit('selectedImage', this.image)
      }
    }
  }
</script>
