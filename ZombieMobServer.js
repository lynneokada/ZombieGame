var express = require('express'),
mongoskin = require('mongoskin'),
bodyParser = require('body-parser'),
mongodb = require('mongodb')

var app = express()
app.use(bodyParser())

var mongoUri = process.env.MONGOLAB_URI ||
process.env.MONGOHQ_URL ||
'mongodb://localhost/test';

var db = mongoskin.db(process.env.MONGOHQ_URL, {safe:true})

app.post('/score', function(req, res)
{
  console.log("meow")
  var score = db.collection("scores")

  score.insert(req.body, {}, function(e, results)
{
  if (e) res.status(500).send()
    res.send(results)
  })
})

var port = Number(process.env.PORT || 3000);
app.listen(port, function() {});
