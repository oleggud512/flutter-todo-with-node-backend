const express = require("express")
const sequelize = require("./src/database")

const todoRouter = require("./src/features/todo/todoRoutes")

sequelize.sync()


const app = express()

app.use(function(error, req, res, next) {
  console.log(req.baseUrl + req.body)
});

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use("/api/v1/todos", todoRouter)

const PORT = process.env.PORT || 3000

app.listen(PORT, () => {
  console.log(`Server is running on ${PORT}!`)
})