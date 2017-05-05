<template>
  <div>
    <img :src="image" v-on:click="clickSelect"/>
  </div>
</template>

<script>

  export default {
    props: ['image'],
    methods: {
      clickSelect: function () {
        console.log(this.image)
        this.$emit('selected_image', this.image)
        
      }
    }
  }
</script>
