import React from 'react';

export default class Game extends React.Component {

    constructor(props) {
        super();
    }

    render() {
        return (
            <div className="game">
                <h1>Ваще Игра!!!</h1>
                <canvas></canvas>
            </div>
        );
    }
}