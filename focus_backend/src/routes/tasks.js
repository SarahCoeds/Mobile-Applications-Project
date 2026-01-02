const express = require("express");
const pool = require("../db");

const router = express.Router();

function generateFocus(task, mood, priority) {
  if (!task) return "Please type a task first.";
  if (mood === "Low" && priority === "High") return `Take it slow. Focus only on ${task}`;
  if (mood === "High" && priority === "Low") return `Mood is good! You can start ${task}`;
  return `Stay focused and work on ${task}`;
}

router.post("/", async (req, res) => {
  try {
    const userId = req.body.userId;
    const title = (req.body.title || "").trim();
    const mood = req.body.mood;
    const priority = req.body.priority;

    if (!userId) return res.status(400).json({ error: "userId is required" });
    if (!title) return res.status(400).json({ error: "title is required" });
    if (!["Low", "Normal", "High"].includes(mood)) return res.status(400).json({ error: "invalid mood" });
    if (!["Low", "Medium", "High"].includes(priority)) return res.status(400).json({ error: "invalid priority" });

    const focusMessage = generateFocus(title, mood, priority);

    const [r] = await pool.query(
      "INSERT INTO tasks (user_id, title, mood, priority, focus_message) VALUES (?,?,?,?,?)",
      [userId, title, mood, priority, focusMessage]
    );

    const [rows] = await pool.query(
      "SELECT id, user_id, title, mood, priority, focus_message, created_at FROM tasks WHERE id = ? LIMIT 1",
      [r.insertId]
    );

    res.json(rows[0]);
  } catch (e) {
    res.status(500).json({ error: "server error" });
  }
});

router.get("/user/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;
    const limit = Math.min(parseInt(req.query.limit || "50", 10), 200);

    const [rows] = await pool.query(
      "SELECT id, title, mood, priority, focus_message, created_at FROM tasks WHERE user_id = ? ORDER BY created_at DESC LIMIT ?",
      [userId, limit]
    );

    res.json(rows);
  } catch (e) {
    res.status(500).json({ error: "server error" });
  }
});

module.exports = router;
