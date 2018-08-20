const mysqlUtil = require("../utils/mysql")
module.exports = {
	getAll: async (req, res) => {
		const connection = await mysqlUtil.connection();
		const [rows] = connection.query('SELECT * from carreer');
	  	res.send({ rows });
	}
}