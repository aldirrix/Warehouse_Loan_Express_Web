const mysqlUtil = require("../utils/mysql");
const moment = require("moment");
module.exports = {
	create: async (req, res) => {
		const {name, carreerID, basket, studentID} = req.body;
		const connection = await mysqlUtil.connection();
		const order = await connection.execute(`INSERT INTO warehouse.order (carreerID, owner, studentID) VALUES (${carreerID}, "${name}", "${studentID}")`);
	  	const date = moment().format("YYYY/MM/DD HH:mm:ss");
	  	let insertItemsQuery = "";
		basket.forEach(item => {
			for (let i = item.quantity - 1; i >= 0; i--) {
				insertItemsQuery += `(${order[0].insertId}, ${item.id}, '${date}'),`;
			}
		});
		await connection.execute(`INSERT INTO orderItem (orderID, itemID, createdAt) VALUES ${insertItemsQuery.slice(0, -1)}`);
	  	connection.end();
	  	res.send({ status: "success" });
	}
}