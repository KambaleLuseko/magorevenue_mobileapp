const { Op } = require("sequelize");
const { clients_taxes } = require("../config/dbconfig.provider");
const uuidGenerator = require("../Helpers/uuidGenerator");
const TaxService = require("../taxes/tax.service");
const client_taxModel = require("./client_tax.model");

const ClientTaxService = {};

ClientTaxService.findAll = async (value) => {
    let condition = {};
    if (value) {
        condition = { [Op.or]: { uuid: value, status: value, taxation_uuid: value } };
    }
    let data = await clients_taxes.findAll(value ? { where: condition } : {});
    for (let index = 0; index < data.length; index++) {
        let taxe = await TaxService.findAll(data[index].dataValues.taxe_uuid);
        data[index].dataValues.taxName = taxe[0].name;
        data[index].dataValues.taxDescription = taxe[0].description;
    }
    return data;
}

ClientTaxService.create = async (data) => {
    if (!data.taxation_uuid || !data.taxe_uuid || !data.amount || !data.dueDate) {
        return { status: 400, data: [], message: "Invalid data submitted" };
    }
    return { status: 200, data: client_taxModel.create(data), message: 'Data saved' }
}

/**
 * 
 * @param Array data 
 * @returns String status
 * @returns String message
 * @returns Array data
 */
ClientTaxService.saveMultiple = async (data) => {
    let hasErrors = false;
    let saveTaxes = [];
    for (let index = 0; index < data.length; index++) {
        if (!data[index].taxation_uuid || !data[index].taxe_uuid || !data[index].amount || !data[index].dueDate) {
            // console.log(data[index]);
            hasErrors = true;
            continue;
        }
        saveTaxes.push({
            uuid: `${uuidGenerator()}${index}`,
            taxation_uuid: data[index].taxation_uuid,
            taxe_uuid: data[index].taxe_uuid,
            amount: data[index].amount,
            dueDate: data[index].dueDate,
            status: data[index].status,
        });
    }
    if (hasErrors == true) {
        return { status: 400, data: [], message: "Invalid data submitted" };
    }
    await clients_taxes.bulkCreate(saveTaxes);
    return { status: 200, data: [], message: 'Data saved' }
}

module.exports = ClientTaxService;