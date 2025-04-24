const mongoose = require('mongoose');

const vendorSchema = new mongoose.Schema({

    fullName: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                const result = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return result.test(value.toLowerCase());
            },
            message: "Please enter a valid email",
        }
    },
    city: {
        type: String,
        default: "",
        trim: true
    },
    state: {
        type: String,
        default: "",
        trim: true
    },
    locality: {
        type: String,
        default: "",
        trim: true
    },
    role: {
        type: String,
        default: "vendor",
        
    },
    password: {
        type: String,
        required: true,
        validate: {
            validator: (value) => value.length >= 4,
            message: "Password should be at least 4 characters long"
        }
    }
});

const Vendor = mongoose.model('Vendor', vendorSchema);
module.exports = Vendor;
