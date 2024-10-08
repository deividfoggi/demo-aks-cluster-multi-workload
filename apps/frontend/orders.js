// create a function to call the orders api to create a new order and return the order id
const XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
module.exports.createOrder = function () {
    var http = new XMLHttpRequest();
    var url = "http://orders:8080/orders";
    var params = JSON.stringify(
        {
            name: "myorder"
        }
    );
    http.open("POST", url, true);
    http.setRequestHeader("Content-type", "application/json");
    http.send(params);
    http.onreadystatechange = function() { 
        // if the order is created successfully, return the order object
        if(http.readyState == 4 && http.status == 200) {
            var order = JSON.parse(http.responseText);
            return order;
        }
    }
    http.onerror = function(error) {
        // if the order is not created successfully, return the error
        return error;
    }
};