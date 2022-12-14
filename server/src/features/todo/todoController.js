const todoRepository = require("./todoRepository")

const getTodos = async (req, res) => {
  todos = await todoRepository.getTodos()
  res.json({status: "OK", data: todos})
}

const getTodo = async (req, res) => {
  const { params: { todoId } } = req
  todo = await todoRepository.getTodo(todoId)
  res.json({status: "OK", data: todo})
}

const updateTodo = async (req, res) => {
  const updates = req.body
  const { params: { todoId } } = req
  newTodo = await todoRepository.updateTodo(todoId, updates)
  res.json({status: "OK", data: newTodo})
}

const addTodo = async (req, res) => {
  const todo = req.body
  newTodo = await todoRepository.addTodo(todo)
  res.json({status: "OK", data: newTodo})
}

const deleteTodo = async (req, res) => {
  const { params: { todoId } } = req
  deletedId = await todoRepository.deleteTodo(todoId)
  res.json({status: "OK", data: deletedId})
}

module.exports = {
  getTodos,
  getTodo,
  updateTodo,
  addTodo,
  deleteTodo
}