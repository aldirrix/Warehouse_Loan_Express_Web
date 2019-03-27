const mysqlUtil = require("../utils/mysql");
const _ = require("lodash");
const moment = require("moment");

module.exports = {
	get: async (req, res) => {
                const connection = await mysqlUtil.connection();
                const filter = req.query.filter || "";

                await connection.execute(`SET @requestID=50000`);
                const [rows] = await connection.execute(`SELECT @requestID:=@requestID+1 AS id, name FROM request WHERE name LIKE "%${filter}%" AND NAME != "" GROUP BY name`);
                const [allTools] = await connection.execute(`SELECT id, name FROM item WHERE name LIKE "%${filter}%"`);
	  	res.send(_.union(allTools, rows));
        },
        create: async (req, res) => {
		const {carreerID, selectedItems} = req.body;
                const connection = await mysqlUtil.connection();
                console.log(selectedItems)
                let insertItemsQuery = "";
	  	const date = moment().format("YYYY/MM/DD HH:mm:ss");

	  	for(let item of selectedItems){
                        insertItemsQuery += `(${item.id < 50000 ? item.id : null}, "${item.name}", ${carreerID}, '${date}'),`;
                }
                console.log(`INSERT INTO request (itemId, name, carreerID, createdAt) VALUES ${insertItemsQuery.slice(0, -1)}`)
                await connection.execute(`INSERT INTO request (itemId, name, carreerID, createdAt) VALUES ${insertItemsQuery.slice(0, -1)}`);
                res.send({ status: "success" });
        },
}