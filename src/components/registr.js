import md5 from 'md5';
import React from 'react';
class Registr extends React.Component {
    constructor(props) {
        super();
        this.setAuth = props.setAuth;
        this.setRegistr = props.setRegistr;
        this.appState = props.appState();
        this.registrRequest = props.registrRequest; 
    }

    async registration() {
        const login = document.getElementById('login_Registr').value;
        const password = document.getElementById('password_Registr').value;
        const passwordRepit = document.getElementById('password_Repit').value;
        if (login && password && passwordRepit) {
            if(password === passwordRepit){
                const hash = md5(login + password);
                const result = await this.registrRequest({ login, hash});
                if (result) {
                    this.appState.login = result.login;
                    this.appState.money = result.money;
                    this.setRegistr(false);
                    this.setAuth(false);
                }
            }
        } else {
            console.log('Не хватает данных!');
        }
    }

    render(){
        return(
            <div className="registr">
                <h1>Регистрация!!!</h1>
                <input type='text' id='login_Registr' placeholder='Логин'></input><br />
                <input type='password' id='password_Registr' placeholder='Пароль'></input><br />
                <input type='password' id='password_Repit' placeholder='Повторите пароль'></input><br />
                <button onClick={() => this.registration()}>Регистрация</button>
            </div>
        );
    }
}

export default Registr;