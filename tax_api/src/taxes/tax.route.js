const TaxController = require('./tax.controller');
const router = require('express').Router();

router.get('/', TaxController.findAll);

module.exports = router;