const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const EmployeeSchema = new Schema({
    name: { type: String, required: true }
    // Добавьте поле идентификатора, если его нет
}, { _id: true }); // _id автоматически добавляется MongoDB

const UserSchema = new Schema({
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    login: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    employees: [EmployeeSchema]
});

module.exports = mongoose.model('User', UserSchema);