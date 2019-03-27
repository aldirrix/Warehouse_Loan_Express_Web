const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 5000;

const itemServices = require('./services/item');
const carreerServices = require('./services/carreer');
const orderServices = require('./services/order');
const requestServices = require('./services/request');
const bodyParser = require('body-parser')
require('dotenv').config()

app.use( bodyParser.json() );
app.use(bodyParser.urlencoded({
  extended: true
}));

app.get('/items', itemServices.getAll);
app.get('/carreers', carreerServices.getAll);
app.post('/order', orderServices.create);
app.get('/requests', requestServices.get);
app.post('/request', requestServices.create);

if (process.env.NODE_ENV === 'production') {
  // Serve any static files
  app.use(express.static(path.join(__dirname, 'client/build')));
  // Handle React routing, return all requests to React app
  app.get('*', function (req, res) {
    res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
  });
}

app.listen(port, () => console.log(`Listening on port ${port}`));