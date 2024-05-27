const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const User = require('../models/User');

// Middleware для проверки JWT токена
const verifyToken = (req, res, next) => {
    const token = req.headers['x-access-token'];
    
    if (!token) {
        return res.status(403).send({ auth: false, message: 'No token provided.' });
    }

    jwt.verify(token, 'supersecret', (err, decoded) => {
        if (err) {
            return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
        }

        req.userId = decoded.id;
        next();
    });
};

// Получение сотрудников пользователя
router.get('/', verifyToken, async (req, res) => {
    const user = await User.findById(req.userId);
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    res.json(user.employees);
});

// Добавление сотрудника
router.post('/', verifyToken, async (req, res) => {
    const { name } = req.body;
    
    const user = await User.findById(req.userId);
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    user.employees.push({ name });
    await user.save();
    
    res.json(user.employees);
});

// Удаление сотрудника
router.delete('/:id', verifyToken, async (req, res) => {
    const { id } = req.params;

    const user = await User.findById(req.userId);
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }

    user.employees.id(id).remove();
    await user.save();
    
    res.json(user.employees);
});

module.exports = router;