const TaxService = require("./tax.service");

let TaxController = {};

TaxController.findAll = async (req, res) => {
    let data = await TaxService.findAll(req.params.value);
    res.status(200).send({ data: data });
}


module.exports = TaxController;