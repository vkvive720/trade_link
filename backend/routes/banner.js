const express = require('express');
const BannerRouter = express.Router();
const Banner = require('../models/banner'); // Ensure correct path

// Create a new banner (POST request)
BannerRouter.post('/api/banner', async (req, res) => {
    try {

        const { image } = req.body;
        console.log(req.body);
        const banner = new Banner({ image });
        await banner.save();
        return res.status(201).json({ message: "Banner created successfully", banner });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

// Get all banners (GET request)
BannerRouter.get('/api/banner', async (req, res) => {
    try {
        const banners = await Banner.find();
        // res.json(banners);
        return res.status(200).send(banners);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = BannerRouter;
