exports.getLogin = (request, response, next) => {
    response.render('login', {
        titulo: 'Inicia sesión',
        isLoggedIn: request.session.isLoggedIn === true ? true : false
    });
};

exports.postLogin = (request, response, next) => {
    request.session.isLoggedIn = true;
    request.session.usuario = request.body.usuario;

    response.redirect('/productos');
};


exports.getLogout = (request, response, next) => {
    request.session.destroy((err) => {
        console.log(err);
        console.log('Logout');
        response.redirect('/productos'); //Este código se ejecuta cuando la sesión se elimina.
    });
};