const { divisions } = require("../config/dbconfig.provider");
const TaxService = require("../taxes/tax.service");

let DivisionController = {};

DivisionController.findAll = async (req, res) => {
    let searchValue = req.params.value;
    let condition = {};
    if (searchValue) {
        condition = { [Op.or]: { name: searchValue, division_uuid: searchValue } };
    }
    let data = await divisions.findAll(searchValue ? { where: condition } : {});
    for (let index = 0; index < data.length; index++) {
        data[index].dataValues.taxes = await TaxService.findAll(data[index].dataValues.uuid);
    }
    res.status(200).send({ data: data });
}

module.exports = DivisionController;