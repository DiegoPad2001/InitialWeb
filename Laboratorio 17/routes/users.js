const express = require('express');

const router = express.Router();

const path = require('path');

const usersController = require('../controllers/users_cont');

router.get('/login', usersController.getLogin);

router.post('/login', usersController.postLogin);

router.get('/logout', usersController.getLogout);//no se si es login

module.exports = router;