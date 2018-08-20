const mysqlUtil = require("../utils/mysql")
module.exports = {
	getAll: async (req, res) => {
		const connection = await mysqlUtil.connection();
		const [rows] = await connection.execute('SELECT item.id, item.name,'+
			'item.quantity - CASE WHEN orderItem.itemID IS NOT NULL THEN count(*) ELSE 0 END AS available '+
		'FROM item '+
		'LEFT JOIN orderItem ON item.id = orderItem.itemID AND orderItem.deletedAt IS NULL '+
		'WHERE departmentID = 4 GROUP BY item.id');
	  	res.send({ rows });
	}
}