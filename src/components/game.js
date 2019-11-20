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
        this.move = props.move;
        this.shoot = props.shoot;
        this.state = {
            isConstructed: false
        }
        // спрайты (картинки)
        this.SPRITE = {
            SPRITE_MAP: new window.Image(),
            GRASS: new window.Image(),
            DECOR: new window.Image(),
            BUILDING_RED: new window.Image(),
            BUILDING_BLUE: new window.Image(),
            TANK_SHASSI_LIGHT: new window.Image(),
            TANK_SHASSI_HARD: new window.Image(),
            TANK_GUN_LIGHT_RED: new window.Image(),
            TANK_GUN_HARD_RED: new window.Image(),
            TANK_GUN_LIGHT_BLUE: new window.Image(),
            TANK_GUN_HARD_BLUE: new window.Image(),
            TANK_HULL_LIGHT_RED: new window.Image(),
            TANK_HULL_HARD_RED: new window.Image(),
            TANK_HULL_LIGHT_BLUE: new window.Image(),
            TANK_HULL_HARD_BLUE: new window.Image(),
            BULLET: new window.Image()
        };

        this.SPRITE.SPRITE_MAP.src = require('../img/Map/map_sprite.png');
        /*поле*/
        this.SPRITE.GRASS.src = require('../img/Blocks/Grass_A.png');
        this.SPRITE.DECOR.src = require('../img/Blocks/Decor_B.png');

        //BASE
        this.SPRITE.BUILDING_RED.src = require('../img/Building/Base_red.png');
        this.SPRITE.BUILDING_BLUE.src = require('../img/Building/Base_blue.png');

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

        this.SPRITE.BULLET.src = require('../img/Tanks/Bomb_A.png');


        this.updateRequest(scene => this.renderScene(scene));

        window.document.onkeypress = event => {
            switch (event.keyCode) {
                case 97: this.move('left'); break; 
                case 100: this.move('right'); break;
                case 119: this.move('up'); break;
                case 115: this.move('down'); break;
                case 32: this.shoot(); break;
            }
        }
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
        const bullets = scene.bullets;
        const tanks = scene.tanks;
        const spriteMap = scene.spriteMap;
        let sprite_map = {};
        for(let i = 0; i < spriteMap.length; i ++){
            sprite_map[spriteMap[i].name] = spriteMap[i];
        }
        for (let i = 0; i < field.length; i++){
            for (let j = 0; j < field[i].length; j++){
                if (field[j][i] === 0) this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, null, sprite_map['GRASS'].x, sprite_map['GRASS'].y, sprite_map['GRASS'].width, sprite_map['GRASS'].height);
                if (field[j][i] > 0 && field[j][i] <= 30) this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, null, sprite_map['STONE_3'].x, sprite_map['STONE_3'].y, sprite_map['STONE_3'].width, sprite_map['STONE_3'].height);
                if(field[j][i] > 30 && field[j][i] <= 70) this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, null, sprite_map['STONE_2'].x, sprite_map['STONE_2'].y, sprite_map['STONE_2'].width, sprite_map['STONE_2'].height);
                if(field[j][i] > 70) this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, null, sprite_map['STONE_1'].x, sprite_map['STONE_1'].y, sprite_map['STONE_1'].width, sprite_map['STONE_1'].height);            
            }
        }
        
        for (let i = 0; i < buildings.length; i++) {
            if (buildings[i].team === '1')
                this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, buildings[i].x*50, buildings[i].y*50, 100, 100, null, sprite_map['BASE_RED'].x, sprite_map['BASE_RED'].y, sprite_map['BASE_RED'].width, sprite_map['BASE_RED'].height); 

            if (buildings[i].team === '2')
                this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, buildings[i].x*50, buildings[i].y*50, 100, 100, null, sprite_map['BASE_BLUE'].x, sprite_map['BASE_BLUE'].y, sprite_map['BASE_BLUE'].width, sprite_map['BASE_BLUE'].height); 

        }
        for(let i = 0; i < bullets.length; i ++){
            if(bullets[i].type == 1){
                this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, bullets[i].direction, sprite_map['BULLET_LIGHT'].x, sprite_map['BULLET_LIGHT'].y, sprite_map['BULLET_LIGHT'].width, sprite_map['BULLET_LIGHT'].height); 
            } else {
                this.canvas.drawImageScale(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, bullets[i].direction, sprite_map['BULLET_HEAVY'].x, sprite_map['BULLET_HEAVY'].y, sprite_map['BULLET_HEAVY'].width, sprite_map['BULLET_HEAVY'].height); 
            }
        }
        for (let i = 0; i < tanks.length; i++) {
            if(tanks[i] !== undefined){
                if (tanks[i].team === '1'){
                    // шасси
                    if (tanks[i].shassisType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_LIGHT, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].shassisType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_HARD, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    //корпус
                    if (tanks[i].hullType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_LIGHT_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].hullType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_HARD_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    //оружие
                    if (tanks[i].gunType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_LIGHT_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].gunType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_HARD_RED, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                }
                if (tanks[i].team === '2'){
                    //шасси
                    if (tanks[i].shassisType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_LIGHT, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].shassisType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_SHASSI_HARD, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    //корпус
                    if (tanks[i].hullType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_LIGHT_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].hullType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_HULL_HARD_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    //оружие
                    if (tanks[i].gunType === '1') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_LIGHT_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                    if (tanks[i].gunType === '2') this.canvas.drawImageScale(this.SPRITE.TANK_GUN_HARD_BLUE, tanks[i].x * 50, tanks[i].y * 50, 50, 50, tanks[i].direction);
                }

            } else if (tanks[i] === undefined) {
                document.getElementsByClassName('tankConstructor')[0].style.display = 'block';
                document.getElementById('canvas').style.display = 'none';    
            } 
        }
        
    }

    logout() {
        this.setAuth(false);
    }

    render() {
        return (
            <div className="game">
                <h1 className='game__name'>Game</h1>
                <div className='menu'>
                    <div id='userInfo'>
                        <span>Money: </span>{this.appState.money}<span> rub</span><br/>
                        <span>Login: </span>{this.appState.login}
                    </div>
                </div>
                {this.state.isConstructed
                 ? <canvas id='canvas'></canvas>
                 : <TankConstructor 
                        addTankRequest = { (data) => this.addTankRequest(data)} 
                        setConstructed = { (val) => this.setConstructed(val)}
                        getConstructor = {() => this.getConstructor()}
                        money = {this.appState.money}
                        setErrors = {this.setErrors}/>
                }
                <div className='btn__in__game' onClick={ 
                    () => {
                        this.logout();
                        this.setConstructed(false);
                }}><div className='blue__btn'><h2>Exit</h2></div></div><br/>
            </div>
        );
    }
}