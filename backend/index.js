const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth'); // Ensure correct path to hello.js
const vendorRouter = require('./routes/vendor');
const  bannerRouter = require('./routes/banner');
const categoryRouter = require('./routes/category');
const subcategoryRouter = require('./routes/sub_category');
const productRouter = require('./routes/products');
const productReviewRouter = require('./routes/productReview');
const cors = require('cors');
// const vendorRouter = require('./routes/vendor');
const PORT = 3000;

const DB = "mongodb+srv://vive0720_multi_store:hello_iiitn@cluster0.zcojo.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
// const DB="mongodb+srv://vickykumar1347:1q2w3e4r@cluster0.3pwsj.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const app = express();
app.use(express.json());
app.use(cors());  //enable for all routes ans origin
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subcategoryRouter);
app.use(productRouter);
app.use(productReviewRouter);
app.use(vendorRouter);


// Connect to MongoDB
mongoose.connect(DB)
    .then(() => {
        console.log("DB connected");
    })
    .catch((err) => {
        console.error("MongoDB connection error:", err);
    });

app.listen(PORT, "0.0.0.0", function () {
    console.log(`Server is running on port ${PORT}`);
});
