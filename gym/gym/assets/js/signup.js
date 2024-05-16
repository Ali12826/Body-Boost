import { firebaseConfig } from './config.js';
const firebaseApp = firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();
const firestore = firebase.firestore();

const signupBtn = document.querySelector('.submit');

signupBtn.addEventListener('click', (e) => {
    e.preventDefault();

    const name = document.querySelector('input[placeholder="NAME"]').value;
    const email = document.querySelector('input[placeholder="EMAIL"]').value.trim();
    const plan = document.querySelector('input[placeholder="YOUR PLAN"]').value;
    const mobile = document.querySelector('input[placeholder="MOBILE NO"]').value;
    const password = document.querySelector('input[placeholder="PASSWORD"]').value;

    auth.createUserWithEmailAndPassword(email, password)
        .then((userCredential) => {
            const user = userCredential.user;
            const uid = user.uid;

            console.log('User data saved to Firestore');
            firestore.collection('admins').doc(uid).set({
                name: name,
                email: email,
                plan: plan,
                mobile: mobile
            });
        })
        .catch((error) => {
            alert('Error signing up: ' + error.message);
        });
});