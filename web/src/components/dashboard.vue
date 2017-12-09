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
            <section class="info row" v-show="!singleDevice">
                <h2 class="display-3" v-show="loading">Loading...</h2>
                <div class="col-6 list__item" v-for="item in data" v-on:click="show(item.name)">
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


            <div class="mt-5" v-show="!singleDevice">
                <h2 class="display-5">Chart</h2>
                <canvas id="chart" width="600" height="400"></canvas>
            </div>

            <div class="mt-5" v-show="singleDevice">
                <h2 class="display-5">Device chart</h2>
                <canvas id="chartSolo" width="800" height="550"></canvas>
                <div class="chart-overlay"></div>
            </div>
        </section>
    </section>
</template>

<script>

	import Chart from 'chart.js'

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

		for (let x in values) {

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

		drawChart(arr, vue);

		return arr;
	}

	function drawChart(data, vue) {
		/*
                Charting
             */

		const names = data.map(it => it.name);

		const values = data.map(it => Math.floor(it.percentage));

		const bgcolors = data.map(it => it.percentage > 50 ? "rgba(40,167,69, 0.2)" : it.percentage < 20 ? "rgba(220,53,69, 0.2)" : "rgba(255,193,7, 0.2)");

		const bordercolors = data.map(it => it.percentage > 50 ? "rgba(40,167,69, 1)" : it.percentage < 20 ? "rgba(220,53,69, 1)" : "rgba(255,193,7, 1)");

		const ctx = document.getElementById('chart').getContext('2d');

		const newChart = new Chart(ctx, {
			type: 'bar',
			data: {
				labels: names,
				datasets: [{
					label: '% of space left',
					data: values,
					backgroundColor: bgcolors,
					borderColor: bordercolors,
					borderWidth: 1
				}]
			},
			options: {
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero: true
						}
					}]
				}
			}
		})
	}

	export default {

		created() {
			if (!this.$cookie.get('user')) this.$router.push('/')
		},
		data() {
			return {
				username: '',
				data: [],
				loading: true,
                singleDevice: false
			}
		},
		mounted() {

			let _this = this;
			dataRef.on('value', snapshot => {
				this.data = parseFirebase(snapshot, _this);
			});

		},
		methods: {
			logout() {
				this.$cookie.delete('user');
				this.$router.push('/');
			},
            show(ele){
				const device = this.data.find(it => it.name === ele);

                this.singleDevice = true;

                const device1 = {};

                const ref = Firebase.database().ref('/reading/' + ele);

                ref.on('value', snapshot => {

                    let arr = [];
                    let i = 0;

                	for (let x in snapshot.val()){
                		if(i < Object.keys(snapshot.val()).length - 10 ) {
                			i++;
                        } else{
							arr.push(snapshot.val()[x]);
                            i++;
                        }
					}

					const percentage = arr.map(it => it.percentage);

                    const time = arr.map(it => it.timestamp);

					const ctx = document.getElementById('chartSolo').getContext('2d');

					const newChart = new Chart(ctx, {
						type: 'line',
						data: {
							labels: time,
							datasets: [{
								label: '% of space left',
								data: percentage,
								backgroundColor: 'rgba(255,0,0,0.2)',
								borderColor: 'rgba(255,0,0,1)',
								borderWidth: 1
							}]
						},
						options: {
							tooltips:{
                                enabled: false
                            },
                            events: {},
							animation: {
                                duration: 1
                            },
							scales: {
								yAxes: [{
									ticks: {
										suggestedMax: 100,
										beginAtZero: true
									}
								}]
							}
						}
					});
                });
            }
		}
	}
</script>

<style lang="scss">
    .dashboard {

        display: flex;
        flex-flow: row nowrap;

        .navbar {
            position: fixed;
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
            margin-top: 5vh;
            margin-left: 200px;
            padding: 0 5vh;

            #chart {
                max-width: 50vw;
                max-height: 50vw;
            }

            .chart-overlay{
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 10000;
            }

            p {
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

                &:hover{
                    cursor: pointer;
                }

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
