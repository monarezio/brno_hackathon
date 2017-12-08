
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
firebase.database().ref('/reading').once('value').then(snapshot => {
	const values = snapshot.val();
	const ids = Object.keys(values);

	const sorted = Object.keys(values).sort((a, b) => {

		const alast = values[a][Object.keys(values[a])[Object.keys(values[a]).length -1]];

		const blast = values[b][Object.keys(values[b])[Object.keys(values[b]).length -1]];


		return blast.percentage - alast.percentage;
	});

	const sortedObjects = sorted.map(it => values[it]);

	firebase.database().ref('').set(sortedObjects)

	//toto update db db > analysis/sorted/

});

