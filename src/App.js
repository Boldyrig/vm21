import React from 'react';
import './css/App.css';

// модули
import Server from './modules/Server';
import appState from './modules/State';
// компоненты
import Auth from './components/auth';
import Game from './components/game';
import Error from './components/error';
import Registr from './components/registr';

class App extends React.Component {
	constructor() {
		super();
    this.server = new Server(err => this.setErrors(err));
    this.appState = new appState();
    this.state = {
      isAuth: false,
      isRegistr: false,
      isError: false,
      errors: []
    }
  }

  setErrors(err) {
    let arr = this.state.errors;
    arr.push(err);
    this.setState({isError: true, errors: arr});
  }

  setAuth(val) {
    if (!val) {
      this.server.logout();
    }
    this.setState({isAuth: val});
  }

  setRegistr(val){
    this.setState({isRegistr: val});
  }

	render () {
    console.log('pererisoval App '+ this.appState.login);
		return (
			<div className="App">
				<h1>ВМ-мехи!!!</h1>
        {this.state.isError ? <Error errors = {() => this.state.errors}/> : null}
          {this.state.isAuth 
          ?
            <Game
                setAuth = {val => this.setAuth(val)}
                updateRequest = {() => this.server.updateScene()}
                addTankRequest = {val => this.server.addTank(val)}
                appState = {() => this.appState}
                getConstructor = {() => this.server.getConstructor()}
                setErrors = {err => this.setErrors(err)}
              />
          : this.state.isRegistr
          ?
          <Registr
            setAuth = {val => this.setAuth(val)}
            setRegistr = {val => this.setRegistr(val)}
            appState = {() => this.appState}
            registrRequest={data => this.server.registration(data)}
          />  
          :<Auth 
            setRegistr = {val => this.setRegistr(val)}
            setAuth = {val => this.setAuth(val)} 
            authRequest={data => this.server.auth(data)}
            appState = {() => this.appState}
            setErrors = {err => this.setErrors(err)}
          />
        }
			</div>
      
		);
	}
}

export default App;