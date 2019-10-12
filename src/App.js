import React from 'react';
import './App.css';

// модули
import Server from './modules/Server';
// компоненты
import Auth from './components/auth';
import Game from './components/game';

class App extends React.Component {

	constructor() {
		super();
		this.server = new Server();
		
		this.state = {
			isAuth: false
		};
	}

	setAuth(isAuth) {
		this.setState({ isAuth });
	}

	render () {
		return (
			<div className="App">
				<h1>ВМ-мехи!!!</h1>
				{
					this.state.isAuth 
						? <Game />
						: <Auth 
							setAuth={value => this.setAuth(value)} 
							authRequest={data => this.server.auth(data)} 
						  />
				}
			</div>
		);
	}
}

export default App;