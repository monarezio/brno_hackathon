<template>
    <section class="dashboard">
        <aside class="navbar navbar-dark bg-dark justify-content-start flex-column">
            <div class="navbar-brand mb-4 mr-0">
                VAMP
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a href="#" v-on:click.prevent="show('trash')" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-trash"></i></span>
                        Trashes
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" v-on:click.prevent="show('lightbubs')" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-lightbulb"></i></span>
                        Lights
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" v-on:click.prevent="logout()" class="nav-link text-danger">
                        <span class="mr-2"><i class="fas fa-sign-out-alt"></i></span>
                        Log out
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link text-light">
                        <span class="mr-2"><i class="fas fa-car"></i></span>
                        Traffic
                    </a>
                </li>
                <li class="nav-item">
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
            width: 150px;
        }

        .jumbotron {
            margin-top: 10vh;
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
