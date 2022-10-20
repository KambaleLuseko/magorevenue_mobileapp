const TaxationController = require('./taxation.controller');
const router = require('express').Router();

router.get('/', TaxationController.findAll);
router.post('/', TaxationController.create);
router.post('/sync', TaxationController.sync);

module.exports = router;