const express=require('express');
const ProductReview=require('../models/productReview');
const productReviewRouter=express.Router();

productReviewRouter.post('/api/product-review', async (req, res) => {

    try{
        const {buyerId,email,fullName,productId,rating,review} = req.body;
        const productReview = new ProductReview({buyerId,email,fullName,productId,rating,review});
        await productReview.save();
        
        return res.status(201).send(productReview);
    }
    catch(error){
        res.status(500).json({error: error.message});
    }
});

productReviewRouter.get('/api/product-reviews', async (req, res) => {
    try{
        const productReviews = await ProductReview.find();
        res.status(200).json({productReviews}); 
    }
    catch(error){
        res.status(500).json({message: error.message});
    }
});


module.exports=productReviewRouter;
