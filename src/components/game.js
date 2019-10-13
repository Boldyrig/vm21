import React from 'react';

export default class Game extends React.Component {

    constructor(props) {
        super();
        this.setAuth = props.setAuth;
        this.updateRequest = props.updateRequest;
    }

    logout() {
        this.setAuth(false);
    }

    update() {
        return this.updateRequest() ;
    }


    render() {
        return (
            <div className="game">
                <h1>Игра!!!</h1>
                <button onClick={() => this.update()}>Начать игру</button><br/>
                <button onClick={() => this.logout()}>Выйди отсюда</button><br/>
                <canvas></canvas>
            </div>
        );
    }
}
