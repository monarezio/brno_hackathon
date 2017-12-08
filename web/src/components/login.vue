<template>
  <section class="login">
    <h1>Smart Brno login</h1>
    <form>
      <div class="form-group">
        <p class="text-danger">{{error}}</p>
      </div>
      <div class="form-group">
        <label for="exampleInputEmail1">Email address</label>
        <input type="email" class="form-control" v-model="email" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Email">
      </div>
      <div class="form-group">
        <label for="exampleInputPassword1">Password</label>
        <input type="password" v-model="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input">
          Stay logged in
        </label>
      </div>
      <button type="submit" v-on:click.prevent="login()" class="btn btn-primary">Log in</button>
    </form>
  </section>
</template>

<script>
  export default {

    created(){
      if (this.$cookie.set('user')) this.$router.push('/dashboard')
    },

    data() {
      return {
        email: '',
        password: '',
        error: ''
      }
    },
    methods: {
      login(){
        if(this.email === 'a@a.a' && this.password === 'a'){
          this.error = '';
          let data = JSON.stringify({ email: this.email, password: this.password});
          this.$cookie.set('user', data);
          this.$router.push('/dashboard');
        } else {
          this.error = 'Wrong combination of username and password!'
        }
      }
    }

  }
</script>

<style lang="scss">

  .login {
    min-height: 100vh;
    display: flex;
    flex-flow: column nowrap;
    justify-content: center;
    align-items: center;
  }

</style>
