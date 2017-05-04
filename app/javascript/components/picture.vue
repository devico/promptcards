<template>
  <div>
    <img v-for="image in images" :src='image'"/>        
  </div>
</template>

<script>

  const pic = '#pictures'
 
   export default { 
    pic,
    data: function () {
      return { 
        images: []
      }
    },
    methods: {
      onClick: function () {
        console.log("Select")
      }
    }
  }
</script>
