const express = require('express');
const Category = require('../models/category'); // Ensure correct path

const categoryRouter = express.Router();


categoryRouter.post('/api/categories', async (req, res) => {
    // res.status(300).send("Hello");

    try{
        const {name, image, banner} = req.body;
        const category = new Category({name, image, banner});
        await category.save();
        return res.status(201).send(category);
    }
    catch(error){
        res.status(500).json({message: error.message});
    }
});

categoryRouter.get('/api/categories', async (req, res) => {
    try{
        const categories = await Category.find();
        res.status(200).json({categories}); 
    }
    catch(error){
        res.status(500).json({message: error.message});
    }
});

module.exports= categoryRouter;