// Import the express library for routes and endpoints
const express = require('express');

// Import mysql2 for database connections
const mysql = require('mysql2/promise');

const app = express();

app.get('/', (req, res) => {
    res.send('Hello From Node JS Backend!');
});


app.get('/allRequests', (req,res) => {

    res.send("Here's All the Requests!");

});


//simple route to validate DB credentials and that you can connect
app.get('/testDB', (req,res) => {

    try {
        const connection = mysql.createConnection({
            host: process.env.DB_HOST, 
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_DATABASE,
            port: process.env.DB_PORT
        });

        res.send("Successfully Connected to the Database!");

    } catch (error) {

        console.log(error);

    }


});


// Make the app listen on port 3000
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
