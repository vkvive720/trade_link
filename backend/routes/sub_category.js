const express = require('express');
const SubCategory = require('../models/sub_category'); // Ensure correct path
const subcategoryRouter = express.Router();

subcategoryRouter.post('/api/subcategories', async (req, res) =>   {
    // res.status(300).send("Hello");

    try{
        const {categoryId,categoryName,image,subcategoryName} = req.body;
        const sub_category = new SubCategory({categoryId,categoryName,image,subcategoryName});
        await sub_category.save();
        
        return res.status(201).send(sub_category);
    }
    catch(error){
        res.status(500).json({error: error.message});
    }
});

subcategoryRouter.get('/api/subcategories', async (req, res) => {
    try{
        const subcategories = await SubCategory.find();
        return res.status(200).send(subcategories);
    }
    catch(error){
        res.status(500).json({error: error.message});
    }
});

subcategoryRouter.get('/api/category/:categoryName/subcategories', async (req, res) => {
    
    try{
        const{categoryName} = req.params;
    const subcategories = await SubCategory.find({categoryName:categoryName});

    if(!subcategories || SubCategory.length == 0){ 
        return res.status(404).send({error: 'Category not found'});
    }
    else{
        return res.send(subcategories);
    }
}
    catch(error){
        res.status(500).json({error: error.message});
    }
    }

    
);

module.exports= subcategoryRouter;