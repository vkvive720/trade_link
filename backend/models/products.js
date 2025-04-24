mongoose = require('mongoose');

const productSchema = new mongoose.Schema({

    productName:{
        type: String,
        required: true,
        trim: true,
    },
    productPrice:{
        type: Number,
        required: true,
        trim: true,
    },
    quantity:{
        type: Number,
        required: true,
        trim: true,
    },
    description:{
        type: String,
        required: true,
       
    },
    category:{
        type: String,
        required: true,
    },
    vendorId:{
        type: String,
        required: true,

    },
     fullName:{
        type: String,
        required: true,
        trim: true,
    },
    subcategory:{
        type: String,
        required: true,
    },
    images: [{
        type: String,
        required: true,
    }],
    popular:{
        type: Boolean,
        default: true,
    },
    recommended:{
        type: Boolean,
        default: true,
    },


});

const Product = mongoose.model('Product', productSchema);
module.exports = Product;
