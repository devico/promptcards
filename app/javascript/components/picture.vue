<template>
  <div>
    <img v-bind:src="image"/>
  </div>
</template>

<script>

  export default {
    props: ['image'],
    methods: {
      onClick: function () {
        console.log("Select")
      }
    }
  }
</script>
