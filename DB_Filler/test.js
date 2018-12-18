var mysql = require("mysql");
var faker = require("faker");

var connection = mysql.createConnection({
    host:'localhost',
    user:'cmulready',
    database:'kernel_schema'
});

var q = 'SELECT * FROM university';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  var uniID=results[0].id;

  console.log(uniID);

  var room = [];

  for(var i = 0; i < 400; i++){
      room.push([
          faker.internet.ipv6(),
          uniID
          ]);
      };

  console.log(room);
  connection.query('INSERT INTO university_room (room_code, university_id) VALUES ?', [room], function(err, result) {
    console.log(err);
    console.log(result);
  });
});
connection.end();