import React from 'react';
import './css/App.css';

// модули
import Server from './modules/Server';
import appState from './modules/State';
// компоненты
import Auth from './components/auth';
import Registr from './components/registr';
import Game from './components/game';


class App extends React.Component {
	constructor() {
		super();
    this.server = new Server();
    this.appState = new appState();
    this.state = {
      isAuth: false,
      isRegistr: false
    }
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
		return (
			<div className="App">
				<h1>ВМ-мехи!!!</h1>
        {this.state.isAuth 
         ?
            <Game
                setAuth = {val => this.setAuth(val)}
                updateRequest={() => this.server.updateScene()}
                addTankRequest={val => this.server.addTank(val)}
                appState = {() => this.appState}
                getConstructor = {() => this.server.getConstructor()}
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
            />
            
        }
			</div>
      
		);
	}
}

export default App;