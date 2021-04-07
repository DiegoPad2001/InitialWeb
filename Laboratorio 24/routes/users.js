const express = require('express');

const isAuth = require('../util/is-auth');

const router = express.Router();

const path = require('path');

const usersController = require('../controllers/users_cont');

router.get('/login', usersController.getLogin);

router.post('/login', usersController.postLogin);

router.get('/logout', isAuth, usersController.getLogout);

router.get('/register', usersController.getRegister);

router.post('/register', usersController.postRegister);


module.exports = router;