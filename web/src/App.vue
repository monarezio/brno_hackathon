<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>


  export default {
    name: 'app',
    data() {
      return {

      }
    }
  }
</script>

<style lang="scss">

  body {
    min-height: 100vh;

    #app {
      height: 100%;
    }
  }
</style>
