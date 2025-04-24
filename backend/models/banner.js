const mongoose = require('mongoose');
const bannerSchema = new mongoose.Schema({
    image:{
        type: String,
        required: true,
    }
});

const Banner = mongoose.model('Banners', bannerSchema);
module.exports = Banner;