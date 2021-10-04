const handler = (req, resp) => {
  return resp.json({ text: "world" });
};

module.exports = handler;
