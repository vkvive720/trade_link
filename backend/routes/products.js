const express = require('express');
const Product = require('../models/products'); // Ensure this path is correct
const productRouter = express.Router();

productRouter.post('/api/add-product', async (req, res) => {
    try {
        console.log(req.body);
        const { productName, productPrice, quantity, description, category,vendorId, fullName, subcategory, images } = req.body;
        console.log(images);

        // Create a new Product instance and save it
        const product = new Product({ productName, productPrice, quantity, description, category,vendorId,fullName, subcategory, images });
        await product.save();

        return res.status(201).send(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

productRouter.get('/api/popular-products', async (req, res) => 
    {
        try{
            const products = await Product.find({popular:true});
            if(!products || products.length == 0){
                return res.status(404).send({error: 'No popular products found'});
            }
            else{
                return res.status(200).json({products});
            }
            
        }
        catch(error){
            res.status(500).json({message: error.message});
        }
    });

    productRouter.get('/api/recommended-products', async (req, res) => 
        {
            try{
                const products = await Product.find({recommended:true});
                if(!products || products.length == 0){
                    return res.status(404).send({error: 'No popular products found'});
                }
                else{
                    return res.status(200).json({products});
                }
                
            }
            catch(error){
                res.status(500).json({message: error.message});
            }
        });

productRouter.get('/api/products-by-category/:category', async (req, res) => {
    try {
        const{category} = req.params;
        const products = await Product.find({category});
        if (!products || products.length == 0) {
            return res.status(404).send({ error: 'No products found' });
        } else {
            return res.status(200).json({ products });
        }
    }
    catch (error) {
        res.status(500).json({ message: error.message });
    }

});

module.exports = productRouter;
