const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../models/User');

// Регистрация пользователя
router.post('/register', async (req, res) => {
    const { firstName, lastName, email, login, password } = req.body;
    const userExists = await User.findOne({ $or: [{ email }, { login }] });

    if (userExists) {
        return res.status(400).json({ error: 'User already exists' });
    }

    const hashedPassword = bcrypt.hashSync(password, 8);
    const newUser = new User({ firstName, lastName, email, login, password: hashedPassword });
    await newUser.save();

    res.json({ message: 'User registered successfully' });
});

// Вход пользователя
router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
        return res.status(400).json({ error: 'User not found' });
    }

    const passwordIsValid = bcrypt.compareSync(password, user.password);

    if (!passwordIsValid) {
        return res.status(400).json({ error: 'Invalid password' });
    }

    const token = jwt.sign({ id: user._id, email: user.email, login: user.login }, 'supersecret', { expiresIn: '1h' });
    res.json({ token, user: { firstName: user.firstName, lastName: user.lastName, email: user.email, login: user.login } });
});

module.exports = router;