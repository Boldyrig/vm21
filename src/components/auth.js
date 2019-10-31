import md5 from 'md5';
import React from 'react';
class Auth extends React.Component {

    constructor(props) {
        super();
        this.authRequest = props.authRequest;
        this.setAuth = props.setAuth;
        this.appState = props.appState();
    }

    async login() {
        const login = document.getElementById('login').value;
        const password = document.getElementById('password').value;
        if (login && password) {
            const rnd = Math.round(Math.random() * 100000);
            const hash = md5(md5(login + password) + rnd);
            const result =  await this.authRequest({login, hash, rnd});
            if(result){
                this.appState.login = result.login;
                this.appState.money = result.money;
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
                <input type='text' id='login' placeholder='Логин'></input><br />
                <input type='password' id='password' placeholder='Пароль'></input><br />
                <button onClick={() => this.login()}>Нажми меня</button>
            </div>
        );
    }
}

export default Auth;