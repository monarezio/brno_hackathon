<template>
  <section class="dashboard">
    <aside class="navbar navbar-dark bg-dark">
      <div class="navbar-brand">
        VAMP
      </div>
      <ul class="nav">
        <li class="nav-item">
          <a href="" class="nav-link"></a>
        </li>
      </ul>
      <footer class="copy">

      </footer>
    </aside>
  </section>
</template>

<script>

 export default {
   data() {
      return {
        username: ''
      }
   }
 }
</script>

<style lang="scss">
.dashboard {

  display: flex;
  flex-flow: row nowrap;

  .navbar{
    height: 100vh;
    width: 150px;
  }

  .jumbotron{
    margin-top: 10vh;
  }

}
</style>
