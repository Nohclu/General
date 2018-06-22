// var studentdata = {
//     id: faker.random.uuid(),
//     fname: faker.name.firstName(),
//     lname: faker.name.lastName(),
//     college_id: faker.random.uuid(),
//     email: faker.internet.email(),
//     password: faker.internet.password(),
//     course_code1: faker.random.alphaNumeric()
// };

// Universities 1 (id PK, name, street, city, country, email1, email2 NULL)
// Modules 300 (id PK, name, code)
// Lectureres 150 (id PK, fname, lname, email, password)
// Rooms / Pis 400 (code PK) (id PK)
// Students 1,200 (id PK, fname, lname, email, password, courseCode, college_id)

var mysql = require("mysql");
var faker = require("faker");

var connection = mysql.createConnection({
    host:'localhost',
    user:'cmulready',
    database:'kernel_schema'
});

var university = [];

for(var i = 0; i < 2; i++){
    if (i % 3 == 0){
    university.push([
        1 + '0045'+Math.floor(Math.random() * 10000) + 1 ,
        faker.internet.domainName(),
        faker.address.streetAddress(),
        faker.address.city(),
        faker.address.country(),
        faker.internet.email(),
        faker.internet.email()
    ]);
    } else {
    university.push([
        i + '0045'+Math.floor(Math.random() * 10000) + 1 ,
        faker.company.companyName(),
        faker.address.streetAddress(),
        faker.address.city(),
        faker.address.country(),
        faker.internet.email(),
        'N/A'
        ]);
    }
}

connection.query('INSERT INTO university (id, name, street, city, country, email_end1, email_end2) VALUES ?', [university], function(err, result) {
  console.log(err);
  console.log(result);
});


var module = [];

for(var i = 0; i < 300; i++){
    module.push([
        i + '0023'+Math.floor(Math.random() * 30000) + 1 ,
        faker.hacker.noun(),
        faker.random.uuid()
        ]);
}

connection.query('INSERT INTO module (id, name, code) VALUES ?', [module], function(err, result) {
  console.log(err);
  console.log(result);
});


var lecturer = [];

for(var i = 0; i < 150; i++){
    lecturer.push([
        i + '0012'+Math.floor(Math.random() * 15000) + 1,
        faker.name.firstName(),
        faker.name.lastName(),
        faker.internet.email(),
        faker.internet.password()
        ]);
}

connection.query('INSERT INTO lecturer (id, fname, lname, email, password) VALUES ?', [lecturer], function(err, result) {
  console.log(err);
  console.log(result);
});


var student = []; 

for(var i = 0; i < 1200; i++){
    if(i % 600 == 0){ student.push([
        i + '1000'+Math.floor(Math.random() * 120000) + 1,
        faker.name.firstName(),
        faker.name.lastName(),
        faker.random.uuid(),
        faker.internet.email(),
        faker.internet.password(),
        faker.lorem.word(),
        faker.lorem.word()
        ]);
        
    // } else {
            student.push([
        i + '1000'+Math.floor(Math.random() * 120000) + 1,
        faker.name.firstName(),
        faker.name.lastName(),
        faker.random.uuid(),
        faker.internet.email(),
        faker.internet.password(),
        faker.lorem.word(),
        'N/A'
        ]); 
    // }
}

connection.query('INSERT INTO student (id, fname, lname, college_id, email, password, course_code1, course_code2) VALUES ?', [student], function(err, result) {
  console.log(err);
  console.log(result);
});

connection.query('SELECT * FROM university', function(err, result, fields) {
  console.log(err);
  var fk = result[0].id;

var room = [];
for(var i = 0; i < 400; i++){
    room.push([
        fk,
        faker.internet.mac()
        ]);
};

// var pi = [];

connection.end();