const DivisionController = require('./division.controller');
const router = require('express').Router();

router.get('/', DivisionController.findAll);

module.exports = router;