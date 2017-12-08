<template>
  <section class="homepage">
    <div class="jumbotron container">
      <img src="../assets/logo.png">
      <h1>{{ msg }}</h1>
      <a href="/login" class="btn btn-success">Log in</a>
    </div>

    <footer>
      <ul class="nav">
        <li class="nav-item">
          <p class="nav-link disabled">Smart Brno @ 2018</p>
        </li>

        <li class="nav-item">
          <a href="/about" class="nav-link">About</a>
        </li>

        <li class="nav-item">
          <a href="/contact" class="nav-link">Contact</a>
        </li>
      </ul>
    </footer>
  </section>
</template>


<script>

  const welcome = 'Welcome to Smart Brno';

  export default {

    data(){
      return {
        msg: welcome
      }
    }
  }
</script>

<style lang="scss">

  .homepage {
    min-height: 100vh;
    width: 100vw;
    display: flex;
    flex-flow: column nowrap;
    align-items: center;
    justify-content: center;

    .jumbotron{
      display: flex;
      flex-flow: column nowrap;
      background: transparent;
      align-items: center;
      justify-content: center;
      margin-bottom: 0;
    }
  }

</style>
