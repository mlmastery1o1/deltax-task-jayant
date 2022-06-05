var mysql = require('mysql2');

var con = mysql.createConnection({
    host: "localhost",
    port: "3306",
    user: "jayant",
    password: "Jayant@123",
    database: "delstaxdb"
    
});

con.connect(function(err){
    if (err) throw err;
    console.log("connected!");
});
module.exports = con;