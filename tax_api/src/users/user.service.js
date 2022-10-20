const { QueryTypes } = require('sequelize');
const dbConnection = require('../config/dbconfig.provider')

const UserService = {};

UserService.findAll = async (value) => {
    let response = await dbConnection.connexion.query('SELECT * FROM users WHERE active=1', { type: QueryTypes.SELECT });
    return response;
}

UserService.login = async (data) => {
    let response = await dbConnection.connexion.query(`SELECT * FROM users WHERE username='${data.username}' AND password='${data.password}' AND active=1`, { type: QueryTypes.SELECT });

    // console.log(response);
    if (response) {
        if (response.length == 1) {
            return { status: 200, data: response[0], message: 'User exists' };
        }
        return { status: 401, data: {}, message: 'Username ou mot de passe incorrect' };
    }
    return { status: 403, data: {}, message: 'Aucune correspondance' };
}

module.exports = UserService;