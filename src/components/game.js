import React from 'react';
import Canvas from '../modules/Canvas';
import TankConstructor from '../components/tankConstructor';

export default class Game extends React.Component {
    constructor(props) {
        super();
        // коллбеки
        this.setAuth = props.setAuth;
        this.updateRequest = props.updateRequest;
        this.addTankRequest = props.addTankRequest;
        this.appState = props.appState();
        this.getConstructor = props.getConstructor;
        this.setErrors = props.setErrors;
        this.state = {
            isConstructed: false
        }
        // спрайты (картинки)
        this.SPRITE = {
            GRASS: new window.Image(),
            DECOR: new window.Image(),
            BUILDING_RED: new window.Image(),
            TANK_SHASSI_LIGHT: new window.Image(),
            TANK_SHASSI_HARD: new window.Image(),
            TANK_GUN_LIGHT_RED: new window.Image(),
            TANK_GUN_HARD_RED: new window.Image(),
            TANK_GUN_LIGHT_BLUE: new window.Image(),
            TANK_GUN_HARD_BLUE: new window.Image(),
            TANK_HULL_LIGHT_RED: new window.Image(),
            TANK_HULL_HARD_RED: new window.Image(),
            TANK_HULL_LIGHT_BLUE: new window.Image(),
            TANK_HULL_HARD_BLUE: new window.Image()
        };
        /*поле*/
        this.SPRITE.GRASS.src = require('../img/Blocks/Grass_A.png');
        this.SPRITE.DECOR.src = require('../img/Blocks/Decor_B.png');
        this.SPRITE.BUILDING_RED.src = require('../img/Building/Base_red.png');

        this.SPRITE.TANK_SHASSI_LIGHT.src = require('../img/Tanks/kolesa.png');
        this.SPRITE.TANK_SHASSI_HARD.src = require('../img/Tanks/gusen.png');
        /*красная команда*/ 
        this.SPRITE.TANK_GUN_LIGHT_RED.src = require('../img/Tanks/light_gun_red.png');
        this.SPRITE.TANK_GUN_HARD_RED.src = require('../img/Tanks/gun_hard_red.png');

        this.SPRITE.TANK_HULL_LIGHT_RED.src = require('../img/Tanks/Light_hull_red.png');
        this.SPRITE.TANK_HULL_HARD_RED.src = require('../img/Tanks/hull_hard_red.png');
        /*синяя команда*/
        this.SPRITE.TANK_GUN_LIGHT_BLUE.src = require('../img/Tanks/gun_light_blue.png');
        this.SPRITE.TANK_GUN_HARD_BLUE.src = require('../img/Tanks/gun_hard_blue.png');

        this.SPRITE.TANK_HULL_LIGHT_BLUE.src = require('../img/Tanks/hull_light_blue.png');
        this.SPRITE.TANK_HULL_HARD_BLUE.src = require('../img/Tanks/hull_hard_blue.png');
    }

    setConstructed(val) {
        this.setState({isConstructed: val});
    }

    componentDidUpdate() {
        this.canvas = new Canvas({ id: 'canvas' });
    }

    renderScene(scene) {
        this.canvas.clear();
        const field = scene.field;
        const buildings = scene.buildings;
        const tanks = scene.tanks;
        const componentsTank = {};
        for (let i = 0; i < field.length; i++){
            for (let j = 0; j < field[i].length; j++){
                if (field[j][i] === 0) this.canvas.drawImageScale(this.SPRITE.GRASS, i*50, j*50, 50, 50);
                if (field[j][i] > 0) this.canvas.drawImageScale(this.SPRITE.DECOR, i*50, j*50, 50, 50);
            }
        }

        for (let i = 0; i < buildings.length; i++) {
            this.canvas.drawImageScale(this.SPRITE.BUILDING_RED, buildings[i].x * 50, buildings[i].y * 50, buildings[i].width * 50, buildings[i].height * 50);
        }

        for (let i = 0; i < tanks.length; i++) {

            if(componentsTank !== undefined){
                if (componentsTank.team === 'TEAM_RED'){
                    /*шасси*/ 
                    if (componentsTank.shasshi === 'WHEELS') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_LIGHT, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.shasshi === 'CATERPILLAR') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_HARD, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    /*корпус*/ 
                    if (componentsTank.hull === 'HULL_LIGHT') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_LIGHT_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.hull === 'HULL_HARD') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_HARD_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    /*оружие*/
                    if (componentsTank.gun === 'GUN_LIGHT') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_LIGHT_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.gun === 'GUN_HARD') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_HARD_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                }
                if (componentsTank.team === 'TEAM_BLUE'){
                    /*шасси*/ 
                    if (componentsTank.shasshi === 'WHEELS') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_LIGHT, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.shasshi === 'CATERPILLAR') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_HARD, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    /*корпус*/ 
                    if (componentsTank.hull === 'HULL_LIGHT') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_LIGHT_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.hull === 'HULL_HARD') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_HARD_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    /*оружие*/
                    if (componentsTank.gun === 'GUN_LIGHT') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_LIGHT_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                    if (componentsTank.gun === 'GUN_HARD') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_HARD_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50);
                }

                document.getElementById('canvas').style.display = 'table';

            } else if (componentsTank === undefined) {
                document.getElementsByClassName('tankConstructor')[0].style.display = 'block';
                document.getElementById('canvas').style.display = 'none';    
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

    render() {
        console.log(this.appState.money);
        return (
            <div className="game">
                <h1>Игра!!!</h1>
                <div id='userInfo'>
                    <span>Ваш баланс: </span>{this.appState.money}<span> рублей</span><br/>
                    <span>Ваш логин: </span>{this.appState.login}
                </div>
                {this.state.isConstructed
                 ? <canvas id='canvas'></canvas>
                 : <TankConstructor 
                        addTankRequest = { (data) => this.addTankRequest(data)} 
                        update = { () => this.update()}
                        setConstructed = { (val) => this.setConstructed(val)}
                        getConstructor = {() => this.getConstructor()}
                        money = {this.appState.money}
                        setErrors = {this.setErrors}/>
                }
                <button onClick={ 
                    () => {
                        this.logout();
                        this.setConstructed(false);
                }}>Выйти отсюда</button><br/>
            </div>
        );
    }
}