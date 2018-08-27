const mysqlUtil = require("../utils/mysql")
module.exports = {
	getAll: async (req, res) => {
		const connection = await mysqlUtil.connection();
		const [rows] = await connection.execute('SELECT * from carreer');
	  	res.send({ rows });
	}
}