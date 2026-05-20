const express = require('express');
const app = express();
const cors = require('cors');

app.use(cors());

const tokenData = {
  name: "HCOINX",
  symbol: "HCXX",
  decimals: 18,
  supply: "1000000",
  owner: "Howard Mosely",
  email: "gmo.hc93@gmail.com"
};

app.get('/api/token', (req, res) => {
  res.json(tokenData);
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log("HCOINX API running on port " + PORT);
});
