require("dotenv").config();
const express = require("express");
const cors = require("cors");

const users = require("./routes/users");
const tasks = require("./routes/tasks");


const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ ok: true });
});

app.use("/users", users);
app.use("/tasks", tasks);

const port = Number(process.env.PORT || 4000);
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
