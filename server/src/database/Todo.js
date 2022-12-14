const { Model, DataTypes } = require("sequelize")

class Todo extends Model {  

  static init(sequelize) {
    super.init({
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
        autoIncrement: true,
      },
      completed: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
      },
      title: {
        type: DataTypes.STRING,
        allowNull: false
      }
    }, { sequelize })
  }
}

module.exports = Todo