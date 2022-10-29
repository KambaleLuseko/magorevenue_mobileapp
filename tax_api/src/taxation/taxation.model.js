module.exports = (sequelize, Sequelize) => {
    const TaxationModel = sequelize.define('taxations', {
        uuid: {
            type: Sequelize.STRING,
            allowNull: false,
            unique: true
        },
        client_uuid: {
            type: Sequelize.STRING,
            allowNull: false
        },
        totalAmount: {
            type: Sequelize.STRING,
            allowNull: false,
        },
        status: {
            type: Sequelize.STRING,
            allowNull: true,
            defaultValue: 'Constatation'
        },
        syncStatus: {
            type: Sequelize.INTEGER,
            allowNull: true,
            defaultValue: 1
        },
        // userID: {
        //     type: Sequelize.INTEGER,
        //     allowNull: false,
        // }
    });
    return TaxationModel;
}