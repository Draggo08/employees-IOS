const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Подключение к MongoDB
mongoose.connect('mongodb://localhost:27017/employees', { useNewUrlParser: true, useUnifiedTopology: true });

// Импорт роутов
const authRoutes = require('./routes/auth');

app.use('/api/auth', authRoutes);

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});