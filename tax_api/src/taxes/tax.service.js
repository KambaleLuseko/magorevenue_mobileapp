const { Op } = require("sequelize");
const { taxes } = require("../config/dbconfig.provider");

let TaxService = {};

TaxService.findAll = async (value) => {
    let searchValue = value;
    let condition = {};
    if (searchValue) {
        condition = { [Op.or]: { name: searchValue, division_uuid: searchValue, uuid: searchValue } };
    }
    let data = await taxes.findAll(value ? { where: condition } : {});
    return data;
}

module.exports = TaxService;