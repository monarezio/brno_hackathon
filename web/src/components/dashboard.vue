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

        <section class="content col d-flex flex-column align-items-center">
            <h1 class="display-1">{{ username }}</h1>
            <section class="info row">
                <h2 class="display-3" v-show="loading">Loading...</h2>
                <div class="col-6 list__item" v-for="item in data">
                    <div class="row">
                        <div class="icon" v-bind:class="item.clas">
                            <i class="fas fa-trash"></i>
                        </div>
                        <div class="desc small">
                            <p class="text-dark">{{ item.name }}</p>
                            <p class="text-muted">{{Math.floor(item.percentage)}}%</p>
                        </div>
                    </div>
                </div>

                <div class="overlay"></div>
            </section>

            <!--<canvas id="chart" width="600" height="400"></canvas>-->
        </section>
    </section>
</template>

<script>

    /*
        Default data
     */

    import Firebase from 'firebase'

    Firebase.initializeApp({
		apiKey: "AIzaSyDX19wtQEpULBLgxnisPqN7iFUF8TTvhP0",
		authDomain: "smart-trash-78dcb.firebaseapp.com",
		databaseURL: "https://smart-trash-78dcb.firebaseio.com",
		projectId: "smart-trash-78dcb",
		storageBucket: "smart-trash-78dcb.appspot.com",
		messagingSenderId: "104734177472"
	});

    const dataRef = Firebase.database().ref('/analysis/sorted');

	let data1 = [];

	function parseFirebase(snapshot, vue) {
        let arr = [];

		const values = snapshot.val();

		for(let x in values) {

			const temp = {
				percentage: values[x].percentage,
				type: values[x].type,
				timestamp: values[x].timestamp,
				name: x,
				clas: values[x].percentage > 50 ? "okay" : values[x].percentage < 20 ? "danger" : "warn"
			};

			arr.push(temp);
		}

		vue.loading = false;

		return arr;
	}

	export default {

		created() {
			if (!this.$cookie.get('user')) this.$router.push('/')
		},
		data() {
			return {
				username: '',
                data: [],
                loading: true
			}
		},
        mounted(){

			let _this = this;
			dataRef.on('value', snapshot => {
				this.data = parseFirebase(snapshot, _this)
			})
        },
		methods: {
			logout() {
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

        .navbar-brand img {
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

        .nav-pills .nav-link.active, .nav-pills .show > .nav-link {
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
        .content {
            margin-top: 10vh;
            padding: 0 10vh;

            p{
                margin-bottom: 0;
            }

            > .row {
                margin: 0;
                position: relative;
            }

            .btn.btn-dark {
                position: relative;
                z-index: 1000;
            }

            .list__item {
                padding: 5px;

                .row {
                    margin: 0;
                    border-radius: 3px;
                }

                .desc {
                    flex: 1 1 auto;
                    background: #efefef;
                    padding: .5em;
                    font-weight: bold;
                }

                .icon {
                    min-width: 50px;
                    min-height: 50px;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    color: #ffffff;
                    background: #28a745;

                    &.okay {
                        background: #28a745;
                    }

                    &.warn {
                        background: #ffc107;
                    }

                    &.danger {
                        background: #dc3545;
                    }
                }
            }
        }

    }
</style>
