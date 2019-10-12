import md5 from 'md5';
import React from 'react';

export default class Auth extends React.Component {

    constructor(props) {
        super();
        this.authRequest = props.authRequest;
        this.setAuth = props.setAuth;
    }

    async login() {
        const login = document.getElementById('login').value;
        const password = document.getElementById('password').value;
        if (login && password) {
            const rnd = Math.round(Math.random() * 100000);
            const hash = md5(md5(login + password) + rnd);
            const result = await this.authRequest({ login, hash, rnd });
            if (result) {
                this.setAuth(true);
            }
        } else {
            console.log('Не хватает данных!');
        }
    }

    render() {
        return (
            <div className="auth">
                <h1>Авторизация!!!</h1>
                <label>Логин:</label><input id="login" /><br />
                <label>Пароль:</label><input id="password" type="password" /><br />
                <button onClick={() => this.login()}>Нажми меня</button>
            </div>
        );
    }
}