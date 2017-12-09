<template>
    <section class="dashboard">
        <aside class="navbar navbar-dark bg-dark justify-content-start flex-column">
            <div class="navbar-brand mb-4 mr-0">
                <img src="../assets/logo.png" alt="Logo">
            </div>
            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <a href="#" class="nav-link active text-light">
                        <span class="mr-2"><i class="fas fa-trash"></i></span>
                        Trash
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-tint"></i></span>
                        Water
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-leaf"></i></span>
                        Polution
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-dollar-sign"></i></span>
                        Machines
                    </a>
                </li>
                <li class="nav-item mt-4">
                    <a href="#" v-on:click.prevent="logout()" class="nav-link text-danger">
                        <span class="mr-2"><i class="fas fa-sign-out-alt"></i></span>
                        Log out
                    </a>
                </li>
            </ul>
            <p class="mt-auto copy text-muted">
                Smart Brno 2018
            </p>
        </aside>

        <section class="content">

        </section>
    </section>
</template>

<script>

	export default {

		created(){
		    if(!this.$cookie.get('user')) this.$router.push('/')
        },
		data() {
			return {
				username: ''
			}
		},
		methods: {
            logout(){
                this.$cookie.delete('user');
                this.$router.push('/');
            }
        }
	}
</script>

<style lang="scss">
    .dashboard {

        display: flex;
        flex-flow: row nowrap;

        .navbar {
            height: 100vh;
            width: 200px;
        }

        .jumbotron {
            margin-top: 10vh;
        }

        .navbar-brand img{
            max-width: 100%;
            max-height: 100%;
        }

        .nav-link {
            font-size: 11px;
            text-transform: uppercase;
            font-weight: bold;

            span {
                width: 11px;
                display: inline-block;
            }
        }

        .nav-pills .nav-link.active, .nav-pills .show>.nav-link{
            background: rgba(0, 0, 0, 0.4) !important;
        }

        .copy {
            font-size: 11px;
            text-transform: uppercase;
            font-weight: bold;
        }

        /*
            Tables, charts
         */
        .content{

        }

    }
</style>
