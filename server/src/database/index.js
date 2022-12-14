const { Sequelize } = require("sequelize")
const Todo = require("./Todo")

const config = require("./config")

const sequelize = new Sequelize(config)

Todo.init(sequelize)

// TODO: associations here

module.exports = sequelize