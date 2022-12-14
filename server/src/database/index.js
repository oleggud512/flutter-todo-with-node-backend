const { Sequelize } = require("sequelize")

const Todo = require("./Todo")

const sequelize = new Sequelize({
  database: "privet",
  username: "root",
  password: "Ab7Cug84",
  host: "localhost",
  port: 3306,
  dialect: "mysql"
})

Todo.init(sequelize)

// TODO: associations here

module.exports = sequelize