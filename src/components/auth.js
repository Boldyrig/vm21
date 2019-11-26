import md5 from 'md5';
import React from 'react';
class Auth extends React.Component {

    constructor(props) {
        super();
        this.authRequest = props.authRequest;
        this.setAuth = props.setAuth;
        this.appState = props.appState();
        this.setRegistr = props.setRegistr;
        this.setErrors = props.setErrors;
    }

    async login() {
        const login = document.getElementById('login').value;
        const password = document.getElementById('password').value;
        if (login && password) {
            const rnd = Math.round(Math.random() * 100000);
            const hash = md5(md5(login + password) + rnd);
            const result = await this.authRequest({ login, hash, rnd });
            if(result){
                this.appState.login = result.login;
                this.appState.money = result.money;
                this.setAuth(true);
            }
        } else {
            this.setErrors({
                code: 100,
                text: 'Не хватает данных для входа'
            });
        }    
    }

    registration() {
        this.setRegistr(true);
    }

    render() {
        return (
            <div className="menu">
                <h1>Authorization</h1>
                <div className='auth'>
                    <div className='menu__input'>
                        <input className='input__login' type='text' id='login' placeholder='Login'></input><br />
                        <input className='input__password' type='password' id='password' placeholder='Password'></input><br />
                    </div>   
                    <div className='menu__btn'>
                        <div className='green__btn' onClick={() => this.login()}>
                            <h2>Sign in</h2>
                        </div>
                        <div className='blue__btn' onClick={() => this.registration()}>
                            <h2>Sigh up</h2>
                        </div>
                    </div>
                </div>    
            </div>
        );
    }
}

export default Auth;