const express = require('express');
const app = express();
const PORT = 8088;


app.get('/', (req, res) => {
    console.log("a request was hit /")
    res.send('Docker hand on practice');
  });

// Route 1
app.get('/hello', (req, res) => {
  res.send('Hello from API 1!');
});

// Route 2
app.get('/status', (req, res) => {
  res.json({ status: 'Server is running fine.' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
