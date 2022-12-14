const express = require("express")
const todoController = require("./todoController")

const router = express.Router()

router.get("/", todoController.getTodos)

router.get("/:todoId", todoController.getTodo)

router.post("/", todoController.addTodo)

router.patch("/:todoId", todoController.updateTodo)

router.delete("/:todoId", todoController.deleteTodo)

module.exports = router