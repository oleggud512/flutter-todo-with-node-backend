const { Op } = require("sequelize")
const Todo = require("../../database/Todo")

const getTodos = () => {
  return Todo.findAll()
}

const getTodo = (todoId) => {
  return Todo.findOne({
    where: {
      id: {
        [Op.eq]: todoId
      }
    }
  })
}

const updateTodo = (todoId, updates) => {
  return Todo.update(updates, {  
    where: {
      id: {
        [Op.eq]: todoId
      }
    }
  })
}

const addTodo = (todo) => {
  return Todo.create(todo)
}

const deleteTodo = (todoId) => {
  return Todo.destroy({
    where: {
      id: {
        [Op.eq]: todoId
      }
    }
  })
}

module.exports = {
  getTodos,
  getTodo,
  updateTodo,
  addTodo,
  deleteTodo
}