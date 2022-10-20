const router = require('express').Router();

router.use('/clients', require('./clients/client.route'));
router.use('/clients-taxes', require('./client_taxes/client_tax.route'));
router.use('/divisions', require('./division/division.route'));
router.use('/taxes', require('./taxes/tax.route'));
router.use('/taxation', require('./taxation/taxation.route'));
router.use('/users', require('./users/user.route'));

module.exports = router;