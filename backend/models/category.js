const mongoose = require('mongoose');


const CategorySchema = new mongoose.Schema({

    name:{
        type: 'string',
        required: true,
    },
    image:{
        type: 'string',
        required: true,
    },
    banner:{
        type: String,
        required: true,
    },

});

const Category = mongoose.model('Category', CategorySchema);

module.exports = Category;