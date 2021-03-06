
/*
	Configuration
 */
const config = require('../config.json');

/*
	Init of Firebase conn
 */
const firebase = require('firebase');

const conn = firebase.initializeApp({
	apiKey: "AIzaSyDX19wtQEpULBLgxnisPqN7iFUF8TTvhP0",
	authDomain: "smart-trash-78dcb.firebaseapp.com",
	databaseURL: "https://smart-trash-78dcb.firebaseio.com",
	projectId: "smart-trash-78dcb",
	storageBucket: "smart-trash-78dcb.appspot.com",
	messagingSenderId: "104734177472"
});

/*
	Analysis #1
 */
const dataRef = firebase.database().ref('/reading');

dataRef.on('value', snapshot => {
	console.log('Data processing');
	const values = snapshot.val();
	const ids = Object.keys(values);

	const sorted = Object.keys(values).sort((a, b) => {

		const alast = values[a][Object.keys(values[a])[Object.keys(values[a]).length -1]];

		const blast = values[b][Object.keys(values[b])[Object.keys(values[b]).length -1]];


		return blast.percentage - alast.percentage;
	});

	let arr = [];

	// TODO beautify

	for (const a  in sorted){

		const parent = values[sorted[a]];

		const lastItem = parent[Object.keys(parent)[Object.keys(parent).length - 1]];

		arr[sorted[a]] = lastItem
	}

	firebase.database().ref('/analysis/sorted').set(arr);

	//toto update db db > analysis/sorted/

});


/*
	Analysis #2
 */
