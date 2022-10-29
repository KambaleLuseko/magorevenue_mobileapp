const { Op } = require('sequelize');
const ClientService = require('../clients/client.service');
const ClientTaxService = require('../client_taxes/client_tax.service');
const { taxations } = require('../config/dbconfig.provider');
const TaxationService = {};
const uuidGenerator = require('../Helpers/uuidGenerator');

TaxationService.findAll = async (value) => {
    let condition = {};
    if (value) {
        condition = { [Op.or]: { uuid: value, status: value, client_uuid: value } };
    }
    let taxationsData = await taxations.findAll(value ? { where: condition } : {});
    for (let index = 0; index < taxationsData.length; index++) {
        let clients = await ClientService.findAll(taxationsData[index].dataValues.client_uuid);
        taxationsData[index].dataValues.client = clients[0];
        taxationsData[index].dataValues.taxes = await ClientTaxService.findAll(taxationsData[index].dataValues.uuid);
    }
    return taxationsData;
}

/**
 * 
 * @param Object data:{uuid, amount, client, taxes}
 * @returns String status
 * @returns String message
 * @returns Array data
 */
TaxationService.create = async (data) => {
    let uuid = data.uuid || uuidGenerator();
    let client = data.client;
    let taxes = data.taxes;
    if (!client.uuid || !data.totalAmount) {
        return { status: 400, data: [], message: "Invalid data submitted" };
    }
    let saveTaxation = {
        uuid: uuid,
        client_uuid: client.uuid,
        totalAmount: data.totalAmount,
        status: 'Constatation',
    }
    let hasErrors = false;
    let saveTaxes = [];
    for (let index = 0; index < taxes.length; index++) {
        if (!taxes[index].taxe_id || !taxes[index].amountPaid || !taxes[index].nextPayment) {
            // console.log(data[index]);
            hasErrors = true;
            continue;
        }
        saveTaxes.push({
            taxation_uuid: uuid,
            taxe_id: taxes[index].taxe_id,
            amountPaid: taxes[index].amountPaid,
            nextPayment: taxes[index].nextPayment,
            recoveryDate: taxes[index].recoveryDate,
            status: taxes[index].status,
            inputsData: taxes[index].inputsData
        });
    }
    if (hasErrors == true) {
        return { status: 400, data: [], message: "Invalid data submitted" };
    }
    try {
        await taxations.create(saveTaxation);
        await ClientTaxService.saveMultiple(saveTaxes);
        return { status: 200, data: [], message: "Data saved" };
    } catch (error) {
        console.log(error.message);
        return { status: 500, data: [], message: "Error occured" };
    }
}

TaxationService.sync = async (data) => {
    let taxationToSave = [];
    let taxesToSave = [];
    if (data.constructor !== Array) {
        return { status: 400, data: [], message: "Invalid data submitted" };
    }
    let hasErrors = false;
    for (let index = 0; index < data.length; index++) {
        let client = data[index].client;
        let uuid = data[index].uuid || uuidGenerator();
        if (!client.uuid) {
            hasErrors = true;
        }
        taxationToSave.push({
            uuid: uuid,
            client_uuid: client.uuid,
            totalAmount: data[index].totalAmount,
            status: data[index].status || 'Constatation',
        })
        let taxes = data[index].taxes;
        for (let taxIndex = 0; taxIndex < taxes.length; taxIndex++) {
            var someDate = new Date();
            var newDueDate = someDate.setDate(someDate.getDate() + 30);
            if (!taxes[taxIndex].taxe_id || !taxes[taxIndex].amountPaid) {
                // console.log(data[index]);
                hasErrors = true;
                continue;
            }
            taxesToSave.push({
                taxe_id: taxes[index].taxe_id,
                amountPaid: taxes[index].amountPaid,
                nextPayment: taxes[index].nextPayment,
                recoveryDate: taxes[index].recoveryDate,
                status: taxes[index].status || 'Pending',
                inputsData: taxes[index].inputsData
            });
        }
    }
    if (hasErrors == true) {
        return { status: 400, data: [], message: "Some submitted data are invalid" };
    }
    try {
        await taxations.bulkCreate(taxationToSave);
        await ClientTaxService.saveMultiple(taxesToSave);
        return { status: 200, data: [], message: "Data saved" };
    } catch (error) {
        console.log(error.message);
        return { status: 500, data: [], message: "Error occured" };
    }
}

module.exports = TaxationService;