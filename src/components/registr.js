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
    logout(){
        this.setRegistr(false);
    }

    render(){
        return(
            <div className="menu">
                <h1>Registration</h1>
                <div className='registr'>
                    <div className='menu__input'>
                        <input className='input__login' type='text' id='login_Registr' placeholder='Login'></input><br />
                        <input className='input__password' type='password' id='password_Registr' placeholder='Password'></input><br />
                        <input className='input__password' type='password' id='password_Repit' placeholder='Confirm password'></input><br />
                    </div>
                    <div className='menu__btn'>
                        <div className='green__btn' onClick={() => this.registration()}>
                            <h2>Sign up</h2>
                            <img src='src\img\blue-btn.png' alt=''/>
                        </div>
                        <div className='blue__btn' onClick={() => this.logout()}>
                            <h2>Back</h2>
                            <img src='src\img\blue-btn.png' alt=''/>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

export default Registr;