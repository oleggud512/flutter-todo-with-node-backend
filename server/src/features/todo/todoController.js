const todoRepository = require("./todoRepository")

const getTodos = async (req, res) => {
  todos = await todoRepository.getTodos()
  res.json({status: "OK", data: todos})
}

const getTodo = async (req, res) => {
  const { params: { todoId } } = req

  todo = await todoRepository.getTodo(todoId)

  if (!todo) {
    res.status(500).json({status: "FAILED", message: `There is no Todo with id ${todoId}`})
    return
  }

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

  try {
    newTodo = await todoRepository.addTodo(todo)
  } catch (error) {
    res.status(500).json({status: "FAILED", message: error})
    return
  }
  
  res.json({status: "OK", data: newTodo})
}

const deleteTodo = async (req, res) => {
  const { params: { todoId } } = req
  deletedId = await todoRepository.deleteTodo(todoId)
  res.json({status: deletedId > 0 ? "OK" : "FAILED", data: deletedId})
}

module.exports = {
  getTodos,
  getTodo,
  updateTodo,
  addTodo,
  deleteTodo
}