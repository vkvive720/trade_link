const express= require('express');
const mongoose= require('mongoose');
const app = express();

const DB="mongodb+srv://vickykumar1347:1q2w3e4r@cluster0.3pwsj.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
// const DB = "mongodb+srv://vive0720_multi_store:hello_iiitn@cluster0.zcojo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
// Connect to MongoDB
mongoose.connect(DB)
    .then(() => {
        console.log("DB connected");
    })
    .catch((err) => {
        console.error("MongoDB connection error:", err);
    });

//Home route
app.get('/', function(req, res){
    res.send("Welcome home");
});

app.get('/notes', function(req, res){
    res.send("this is notes app");
});

app.listen(5000, function(){
    console.log("server listening on port: 5000 ");
});