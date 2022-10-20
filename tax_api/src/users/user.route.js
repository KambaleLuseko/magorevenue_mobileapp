const router = require('express').Router();
const UserService = require('./user.service');

router.get('/', async (req, res) => {
    res.status(200).send({ data: await UserService.findAll() })
});
router.post('/login', async (req, res) => {
    let user = await UserService.login(req.body);
    res.status(user.status).send({ data, message } = user);
});

module.exports = router;