<template>
  <section class="dashboard">
    <aside class="navbar navbar-dark bg-dark justify-content-start flex-column">
      <div class="navbar-brand mb-4 mr-0">
        VAMP
      </div>
      <ul class="nav flex-column">
        <li class="nav-item">
          <a href="#" class="nav-link"><i class="fas fa-trash mr-2"></i>Trashes</a>
        </li>
        <li class="nav-item">
          <a href="#" class="nav-link"><i class="fas fa-lightbulb mr-2"></i>Lights</a>
        </li>
      </ul>
        <p class="mt-auto copy text-muted">
          Smart Brno 2018
        </p>
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

  .nav-link{
    font-size: 11px;
    text-transform: uppercase;
    font-weight: bold;
  }

  .copy{
    font-size: 11px;
    text-transform: uppercase;
    font-weight: bold;
  }

}
</style>
