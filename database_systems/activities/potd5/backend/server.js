// Import the express library
const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send('Goodbye World!');
});

// Make the app listen on port 3000
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
