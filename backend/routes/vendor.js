const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Vendor = require('../models/vendor'); // Ensure correct path



const vendorRouter = express.Router();

// 📌 SIGNUP ROUTE
vendorRouter.post('/api/vendor/signup', async (req, res) => {
    console.log(req.body);
    try {
        const { fullName, email, password } = req.body;

        // Check if the email already exists
        // const existingUser = await Vendor.findOne({ email });
        // if (existingUser) {
        //     return res.status(400).json({ message: "User with the same email already exists" });
        // }

        // Hash the password before saving
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create and save the new user
        const newUser = new Vendor({ fullName, email, password: hashedPassword });
        await newUser.save();

        res.status(200).json({ message: "User created successfully" });
    } catch (e) {
        res.status(500).json({ message: "Internal server error", error: e.message });
    }
});

// 📌 SIGNIN ROUTE
vendorRouter.post('/api/vendor/signin', async (req, res) => {
    try {
        console.log(req.body);
        const { email, password } = req.body;

        // Check if user exists
        const vendor = await Vendor.findOne({ email });
        if (!vendor) {
            return res.status(400).json({ message: "User does not exist" });
        }

        // Compare passwords
        const isMatch = await bcrypt.compare(password, vendor.password);
        if (!isMatch) {
            return res.status(400).json({ message: "Wrong password" });
        }

        // Generate JWT Token
        const token = jwt.sign({ id: vendor._id }, "passwordKey", { expiresIn: "1h" });

        // Remove password before sending response
        const vendorWithoutPassword = vendor.toObject();
        delete vendorWithoutPassword.password;

        res.status(200).json({ message: "User signed in successfully", user: vendorWithoutPassword, token });
    } catch (e) {
        res.status(500).json({ message: "Internal server error", error: e.message });
    }
});

module.exports = vendorRouter;
