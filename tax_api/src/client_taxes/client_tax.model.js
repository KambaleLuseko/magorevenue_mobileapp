module.exports = (sequelize, Sequelize) => {
    const clientTaxModel = sequelize.define('client_taxes', {
        uuid: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
        },
        taxation_uuid: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        taxe_uuid: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        amount: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        dueDate: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        status: {
            type: Sequelize.STRING,
            allowNull: true,
            defaultValue: 'Constatation'
        },
        active: {
            type: Sequelize.INTEGER,
            allowNull: true,
            defaultValue: 1
        },
        syncStatus: {
            type: Sequelize.INTEGER,
            allowNull: true,
            defaultValue: 1
        },
    });
    return clientTaxModel;
}