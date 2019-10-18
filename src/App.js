import React from 'react';
import './css/App.css';

// модули
import Server from './modules/Server';
// компоненты
import Auth from './components/auth';
import Game from './components/game';
import TankConstructor from './components/tankConstructor';

class App extends React.Component {
	constructor() {
		super();
    this.server = new Server();
    this.state = {
      isAuth: false
    }
	}

  setAuth(val){
    this.setState({isAuth: val});
  }

	render () {
		return (
			<div className="App">
				<h1>ВМ-мехи!!!</h1>
        {this.state.isAuth 
         ?
            <Game
                setAuth = {(val) => this.setAuth(val)}
                updateRequest={() => this.server.updateScene()}
                joinRequest={(val) => this.server.joinGame(val)}
              />
         : <Auth 
              setAuth = {(val) => this.setAuth(val)} 
              authRequest = {data => this.server.auth(data)} 
            />
        }
			</div>
      
		);
	}
}

export default App;