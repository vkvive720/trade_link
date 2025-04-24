const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRouter = express.Router();

// 📌 SIGNUP ROUTE
authRouter.post('/api/signup', async (req, res) => {
    console.log(req.body);
    try {
        const { fullName, email, password } = req.body;

        // Check if the email already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: "User with the same email already exists" });
        }

        // Hash the password before saving
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create and save the new user
        const newUser = new User({ fullName, email, password: hashedPassword });
        await newUser.save();

        res.status(200).json({ message: "User created successfully" });
    } catch (e) {
        res.status(500).json({ message: "Internal server error", error: e.message });
    }
});

// 📌 SIGNIN ROUTE
authRouter.post('/api/signin', async (req, res) => {
    try {
        console.log(req.body);
        const { email, password } = req.body;

        // Check if user exists
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: "User does not exist" });
        }

        // Compare passwords
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: "wrong password" });
        }

        // Generate JWT Token
        const token = jwt.sign({ id: user._id }, "passwordKey", { expiresIn: "1h" });

        // Remove password before sending response
        const userWithoutPassword = user.toObject();
        delete userWithoutPassword.password;

        res.status(200).json({ message: "User signed in successfully", user: userWithoutPassword, token });
    } catch (e) {
        res.status(500).json({ message: "Internal server error", error: e.message });
    }
});

module.exports = authRouter;
