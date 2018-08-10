const mysqlUtil = require("../utils/mysql")
module.exports = {
	getAll: async (req, res) => {
		const connection = await mysqlUtil.connection();
		connection.query('SELECT * from carreer', (err, rows, fields) =>{
	  		if (err) throw err
	  		res.send({ rows });
	  	});
	  	connection.end();
	}
}