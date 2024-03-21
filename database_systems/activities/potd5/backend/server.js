//Necessary Node Libraries, Express for Routes, Mysql2 for MySQL connection and CORS to allow communication with frontend.
const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
    res.send('Hello From Node JS Backend!');
});


const pool = mysql.createPool({
    connectionLimit: 10, // This is the max number of connections in the pool
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT
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

//allRequests Endpoint:
app.get('/allRequests', async (req,res) => {

    const query = "SELECT * FROM requests";

    try {

        const connection = await pool.getConnection();
        const [rows] = await connection.query(query);

        connection.release();

        res.json(rows);

    } catch (error) {
        console.error("An Error Occured While Fetching All Requests");
        res.status(500).send("Error fetching all requests");
    }

});

//addRequst Endpoint:
app.post('/addRequest', async (req, res) => {
    
    const { reqDate, roomNumber, reqBy, repairDesc, reqPriority } = req.body;

    console.log(reqDate);

    const query = "INSERT INTO requests (reqDate, roomNumber, reqBy, repairDesc, reqPriority) VALUES (?,?,?,?,?)";

    try {
        const connection = await pool.getConnection();
        await connection.query(query, [reqDate, roomNumber, reqBy, repairDesc, reqPriority]);
        connection.release();
        res.send("Request Added Successfully!");
    } catch (error) {
        console.error("An Error Occurred", error);
        res.status(500).send("Error processing your request");
    }
});

//updateRequest Endpoint:
app.put('/updateRequest', async (req, res) => {

    const { reqId, reqDate, roomNumber, reqBy, repairDesc, reqPriority } = req.body;
 
    const query = `
        UPDATE requests 
        SET
            reqDate = ?,
            roomNumber = ?,
            reqBy = ?,
            repairDesc = ?,
            reqPriority = ?
        WHERE
            reqId = ?`;

    try {

        const connection = await pool.getConnection();
        const [result] = await connection.query(query, [reqDate, roomNumber, reqBy, repairDesc, reqPriority, reqId]);
        connection.release();

        if(result.affectedRows > 0) {
            console.log(`Rows Successfully Updated for Request ID: ${reqId}`);
            res.send(`Rows Successfully Updated for Request ID: ${reqId}`);
        } else {
            console.log("No Rows With Specified ID to Update");
            res.send("No Rows With Specified ID to Update");
        }

    } catch (error) {
        console.error("An Error Occured While Updating a Request", error);
        res.status(500).send("An Error Occured While Updating a Request");
    }
    


});

//deleteRequest Endpoint:
app.delete("/deleteRequest", async (req, res) => {

    const {reqId} = req.body;

    const query = "DELETE FROM requests where reqId = ?";

    try {

        const connection = await pool.getConnection();
        const [result] = await connection.query(query, [reqId]);
        connection.release(); 

        if(result.affectedRows > 0) {
            console.log(`Row Successfully Deleted for Request ID: ${reqId}`);
            res.send(`Row Successfully Deleted for Request ID: ${reqId}`);
        } else {
            console.log("No Rows With Specified ID to Delete");
            res.send("No Rows With Specified ID to Delete");
        }

    } catch (error) {
        console.error("An Error Occured While Deleting a Request", error);
        res.status(500).send("An Error Occured While Deleting a Request");

    }

});

// Make the app listen on port 3000
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});

//graceful shutdown of database connections:
process.on('SIGINT', async () => {
    console.log('Received SIGINT. Shutting down gracefully.');
    await pool.end();
    process.exit(0);
});

//graceful shutdown of database connections:
process.on('SIGTERM', async () => {
    console.log('Received SIGTERM. Shutting down gracefully.');
    await pool.end();
    process.exit(0);
});
