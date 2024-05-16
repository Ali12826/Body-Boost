import { firebaseConfig } from './config.js';
const firebaseApp = firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();
const firestore = firebase.firestore();

const loginBtn = document.querySelector('.submit');

loginBtn.addEventListener('click', (e) => {
    e.preventDefault();

    const email = document.querySelector('input[type="email"]').value.trim();
    const password = document.querySelector('input[type="password"]').value;

    auth.signInWithEmailAndPassword(email, password)
        .then((userCredential) => {
            if (userCredential.user) {
                console.log('Login successful!');
                window.location.href = "home.html";
            }
        })
        .catch((error) => {
            alert('Error logging in: ' + error.message);
        });
});