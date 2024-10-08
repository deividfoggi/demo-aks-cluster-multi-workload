//create a new web server that serves index.html
var express = require('express');
var orders = require('./orders.js');
var app = express();
var hostname = require('os').hostname();

const PORT = 80;

// exposes public folder as static assets
app.use(express.static(__dirname + '/public'));

app.get('/createorder', function(req, res){
        res.send(orders.createOrder());
    }
);

app.get('/hostname', function(req, res){
        res.send(hostname);
    }
);

app.listen(PORT, () => {
    console.log(`Running on port ${PORT}`);
});