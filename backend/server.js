const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const port = 3000;

app.use(bodyParser.json());

// Подключение к MongoDB, исправление устаревших опций
mongoose.connect('mongodb://localhost:27017/employees', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log('MongoDB connected');
}).catch((error) => {
    console.error('MongoDB connection error:', error);
});

// Импорт роутов
const authRoutes = require('./routes/auth');
const employeeRoutes = require('./routes/employees');

app.use('/api/auth', authRoutes);
app.use('/api/employees', employeeRoutes);

app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});