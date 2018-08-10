const express = require('express');

const app = express();
const port = process.env.PORT || 5000;
const itemServices = require('./services/item');
const carreerServices = require('./services/carreer');
const orderServices = require('./services/order');
const bodyParser = require('body-parser')
require('dotenv').config()

app.use( bodyParser.json() );
app.use(bodyParser.urlencoded({
  extended: true
}));

app.get('/items', itemServices.getAll);
app.get('/carreers', carreerServices.getAll);
app.post('/order', orderServices.create);

app.listen(port, () => console.log(`Listening on port ${port}`));