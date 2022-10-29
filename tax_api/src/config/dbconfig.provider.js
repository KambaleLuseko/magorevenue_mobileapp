const Sequelize = require("sequelize");
const dbConfig = require('../config/dbconfig');

const connexion = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
    host: dbConfig.HOST,
    port: dbConfig.port,
    dialect: dbConfig.dialect,
    operatorsAliases: false,
    pool: {
        max: dbConfig.pool.max,
        min: dbConfig.pool.min,
        acquire: dbConfig.pool.acquire,
        idle: dbConfig.pool.idle
    }
});

let database = {};
database.connexion = connexion;
database.clients = require('../clients/client.model')(connexion, Sequelize);
database.clients_taxes = require('../client_taxes/client_tax.model')(connexion, Sequelize);
database.divisions = require('../division/division.model')(connexion, Sequelize);
database.taxes = require('../taxes/tax.model')(connexion, Sequelize);
database.taxeInputs = require('../taxes_inputs/taxe_inputs.model')(connexion, Sequelize);
database.infoTaxePayment = require('../info_taxe_payment/info_taxe_payment.model')(connexion, Sequelize);
database.taxations = require('../taxation/taxation.model')(connexion, Sequelize);

module.exports = database;