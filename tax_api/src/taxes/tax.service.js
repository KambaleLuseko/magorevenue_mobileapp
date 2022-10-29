const { Op } = require("sequelize");
const { taxes } = require("../config/dbconfig.provider");
const TaxeInputsService = require("../taxes_inputs/taxe_inputs.service");

let TaxService = {};

TaxService.findAll = async (value) => {
    let searchValue = value;
    let condition = {};
    if (searchValue) {
        condition = { [Op.or]: { name: searchValue, division_id: searchValue, uuid: searchValue } };
    }
    let data = await taxes.findAll(value ? { where: condition } : {});

    // console.log(data);
    // let data = await divisions.findAll(searchValue ? { where: condition } : {});
    for (let index = 0; index < data.length; index++) {
        data[index].dataValues.inputs = await TaxeInputsService.findAll(data[index].dataValues.id);
    }
    return data;
}

module.exports = TaxService;