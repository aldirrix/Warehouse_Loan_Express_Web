const mysqlUtil = require("../utils/mysql");
const moment = require("moment");
module.exports = {
	create: async (req, res) => {
		console.log("qpedo")
		const {name, carreerID, basket, studentID} = req.body;
		const connection = await mysqlUtil.connection();
		const order = await connection.execute(`INSERT INTO warehouse.order (carreerID, owner, studentID) VALUES (${carreerID}, "${name}", "${studentID}")`);
	  	const date = moment().format("YYYY/MM/DD HH:mm:ss");
	  	let insertItemsQuery = "";
	  	let orderCanBeSet = true;
	  	for(let item of basket){
	  		const [itemData] = await connection.execute('SELECT item.quantity - CASE WHEN orderItem.itemID IS NOT NULL THEN count(*) ELSE 0 END AS available '+
				'FROM item '+
				'LEFT JOIN orderItem ON item.id = orderItem.itemID AND orderItem.deletedAt IS NULL '+
				`WHERE item.id = ${item.id} `+
				'GROUP BY item.id');
	  		for(let i = item.quantity - 1; i >= 0; i--){
				insertItemsQuery += `(${order[0].insertId}, ${item.id}, '${date}'),`;
			}
			if((itemData[0].available - item.quantity) < 0 ) orderCanBeSet = false;
	  	}
	  	console.log(orderCanBeSet)
	  	if(orderCanBeSet){
			await connection.execute(`INSERT INTO orderItem (orderID, itemID, createdAt) VALUES ${insertItemsQuery.slice(0, -1)}`);
		  	res.send({ status: "success" });
	  	}else{
	  		await connection.execute(`UPDATE warehouse.order SET deletedAt = "${date}" WHERE id = ${order[0].insertId}`);
	  		res.status(500).send('Quantity Missmatch');
	  	}
	}
}