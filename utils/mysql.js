const mysql = require('mysql2/promise');

module.exports = {
	connection: async () => {
		return await mysql.createConnection({
			host     : process.env.DB_HOST,
			user     : process.env.DB_USER,
			password : process.env.DB_PASS,
			database : process.env.DATABASE
		});
	}
}
