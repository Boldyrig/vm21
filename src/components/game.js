import React from 'react';
import Canvas from '../modules/Canvas';
import TankConstructor from '../components/tankConstructor';

export default class Game extends React.Component {
    constructor(props) {
        super();
        // коллбеки
        this.setAuth = props.setAuth;
        this.updateRequest = props.updateRequest;
        this.joinRequest = props.joinRequest;
        // спрайты (картинки)
        this.SPRITE = {
            GRASS: new window.Image(),
            DECOR: new window.Image()
        };
        this.SPRITE.GRASS.src = require('../img/Blocks/Grass_A.png');
        this.SPRITE.DECOR.src = require('../img/Blocks/Decor_B.png');
    }

    componentDidMount() {
        this.canvas = new Canvas({ id: 'canvas' });
    }

    renderScene(scene) {
        this.canvas.clear();
        const field = scene.field;
        for (let i = 0; i < field.length; i++){
            for (let j = 0; j < field[i].length; j++){
                if (field[j][i] === 0) this.canvas.drawImageScale(this.SPRITE.GRASS, i*50, j*50, 50, 50);
                if (field[j][i] > 0) this.canvas.drawImageScale(this.SPRITE.DECOR, i*50, j*50, 50, 50);
            }
        }
        
    }

    logout() {
        this.setAuth(false);
    }

    async update() {
        const scene = await this.updateRequest();
        this.renderScene(scene);
    }

    // Берем собранный танк
    buildTank(){
        const hull = document.getElementsByName('hull')[0].value;
        const gun = document.getElementsByName('gun')[0].value;
        const shasshi = document.getElementsByName('shasshi')[0].value;
        return {
            "hull": hull,
            "gun": gun,
            "shasshi": shasshi
        };
    }

    render() {
        return (
            <div className="game">
                <h1>Игра!!!</h1>
                <TankConstructor />
                <button onClick={() => {
                    this.update(); 
                    this.joinRequest(this.buildTank());  // Отправляем запрос на сервер для создания нового танка с параметрами из конструктора
                    document.getElementsByClassName('tankConstructor')[0].style.display = 'none';  // Скрываем конструктор танка
                    }}>Начать игру</button><br />
                <button onClick={ () => this.logout() }>Выйди отсюда</button><br/>
                <canvas id='canvas'></canvas>
            </div>
        );
    }
}