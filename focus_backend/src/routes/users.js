const express = require("express");
const pool = require("../db");

const router = express.Router();

router.post("/login", async (req, res) => {
  try {
    const name = (req.body.name || "").trim();
    if (!name) return res.status(400).json({ error: "name is required" });

    const [found] = await pool.query(
      "SELECT id, name, created_at FROM users WHERE name = ? LIMIT 1",
      [name]
    );

    if (found.length > 0) return res.json(found[0]);

    await pool.query("INSERT INTO users (name) VALUES (?)", [name]);

    const [created] = await pool.query(
      "SELECT id, name, created_at FROM users WHERE name = ? LIMIT 1",
      [name]
    );

    res.json(created[0]);
  } catch (e) {
res.status(500).json({ error: "server error" });

}

});

module.exports = router;
