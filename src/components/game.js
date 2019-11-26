import React from 'react';
import Canvas from '../modules/Canvas';
import TankConstructor from '../components/tankConstructor';

export default class Game extends React.Component {
    constructor(props) {
        super();
        // коллбеки
        this.setAuth = props.setAuth;
        this.updateRequest = props.updateRequest;
        this.stopRequest = props.stopRequest;
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
            // GRASS: new window.Image(),
            // DECOR: new window.Image(),
            // BUILDING_RED: new window.Image(),
            // BUILDING_BLUE: new window.Image(),
            // TANK_SHASSI_LIGHT: new window.Image(),
            // TANK_SHASSI_HARD: new window.Image(),
            // TANK_GUN_LIGHT_RED: new window.Image(),
            // TANK_GUN_HARD_RED: new window.Image(),
            // TANK_GUN_LIGHT_BLUE: new window.Image(),
            // TANK_GUN_HARD_BLUE: new window.Image(),
            // TANK_HULL_LIGHT_RED: new window.Image(),
            // TANK_HULL_HARD_RED: new window.Image(),
            // TANK_HULL_LIGHT_BLUE: new window.Image(),
            // TANK_HULL_HARD_BLUE: new window.Image(),
            // BULLET: new window.Image()
        };

        this.SPRITE.SPRITE_MAP.src = require('../img/Map/map_sprite.png');
        // /*поле*/
        // this.SPRITE.GRASS.src = require('../img/Blocks/Grass_A.png');
        // this.SPRITE.DECOR.src = require('../img/Blocks/Decor_B.png');

        // //BASE
        // this.SPRITE.BUILDING_RED.src = require('../img/Building/Base_red.png');
        // this.SPRITE.BUILDING_BLUE.src = require('../img/Building/Base_blue.png');

        // this.SPRITE.TANK_SHASSI_LIGHT.src = require('../img/Tanks/kolesa.png');
        // this.SPRITE.TANK_SHASSI_HARD.src = require('../img/Tanks/gusen.png');
        // /*красная команда*/ 
        // this.SPRITE.TANK_GUN_LIGHT_RED.src = require('../img/Tanks/light_gun_red.png');
        // this.SPRITE.TANK_GUN_HARD_RED.src = require('../img/Tanks/gun_hard_red.png');

        // this.SPRITE.TANK_HULL_LIGHT_RED.src = require('../img/Tanks/Light_hull_red.png');
        // this.SPRITE.TANK_HULL_HARD_RED.src = require('../img/Tanks/hull_hard_red.png');
        // /*синяя команда*/
        // this.SPRITE.TANK_GUN_LIGHT_BLUE.src = require('../img/Tanks/gun_light_blue.png');
        // this.SPRITE.TANK_GUN_HARD_BLUE.src = require('../img/Tanks/gun_hard_blue.png');

        // this.SPRITE.TANK_HULL_LIGHT_BLUE.src = require('../img/Tanks/hull_light_blue.png');
        // this.SPRITE.TANK_HULL_HARD_BLUE.src = require('../img/Tanks/hull_hard_blue.png');
        // this.SPRITE.BULLET.src = require('../img/Tanks/Bomb_A.png');

        this.updateRequest(scene => {
            if (scene && (scene.die || scene.gameover)) {
                this.stopRequest(); // stop update scene
                alert("Ты подох"); // write: 'Ты подох!!!'
                this.setConstructed(false); // go to constructor
            } else {
                this.renderScene(scene);
            }
        });

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
        const booms = scene.booms;
        const spriteMap = scene.spriteMap;
        let sprite_map = {};
        for(let i = 0; i < spriteMap.length; i ++){
            sprite_map[spriteMap[i].name] = spriteMap[i];
        }
        for (let i = 0; i < field.length; i++){
            for (let j = 0; j < field[i].length; j++){
                if(field[j][i] === 0) this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, sprite_map, 'GRASS');
                if(field[j][i] > 0 && field[j][i] <= 30) this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, sprite_map, 'STONE_3');
                if(field[j][i] > 30 && field[j][i] <= 70) this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, sprite_map, 'STONE_2');
                if(field[j][i] > 70) this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, i*50, j*50, 50, 50, sprite_map, 'STONE_1');
            }
        }
        
        for (let i = 0; i < buildings.length; i++) {
            if (buildings[i].team === '1')
            this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, buildings[i].x*50, buildings[i].y*50, 100, 100, sprite_map, 'BASE_RED');

            if (buildings[i].team === '2')
            this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, buildings[i].x*50, buildings[i].y*50, 100, 100, sprite_map, 'BASE_BLUE');

        }
        for(let i = 0; i < bullets.length; i ++){
            if(bullets[i].type == 1){
                this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, sprite_map, 'BULLET_LIGHT', bullets[i].direction);
            } else {
                this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, sprite_map, 'BULLET_HEAVY', bullets[i].direction);
            }
        }
        for (let i = 0; i < tanks.length; i++) {
            if(tanks[i] !== undefined){
                if (tanks[i].team === '1'){
                    // шасси
                    if (tanks[i].shassisType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'SHASSIS_LIGHT', tanks[i].direction);
                    if (tanks[i].shassisType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'SHASSIS_HEAVY', tanks[i].direction);
                    //корпус
                    if (tanks[i].hullType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'HULL_LIGHT_RED', tanks[i].direction);
                    if (tanks[i].hullType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'HULL_HEAVY_RED', tanks[i].direction);
                    //оружие
                    if (tanks[i].gunType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'GUN_LIGHT_RED', tanks[i].direction);
                    if (tanks[i].gunType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'GUN_HEAVY_RED', tanks[i].direction);
                }
                if (tanks[i].team === '2'){
                    // шасси
                    if (tanks[i].shassisType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'SHASSIS_LIGHT', tanks[i].direction);
                    if (tanks[i].shassisType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'SHASSIS_HEAVY', tanks[i].direction);
                    //корпус
                    if (tanks[i].hullType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'HULL_LIGHT_BLUE', tanks[i].direction);
                    if (tanks[i].hullType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'HULL_HEAVY_BLUE', tanks[i].direction);
                    //оружие
                    if (tanks[i].gunType === '1') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'GUN_LIGHT_BLUE', tanks[i].direction);
                    if (tanks[i].gunType === '2') this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, tanks[i].x*50, tanks[i].y*50, 50, 50, sprite_map, 'GUN_HEAVY_BLUE', tanks[i].direction);
                }

            } else if (tanks[i] === undefined) {
                continue;   
            }

            for(let i = 0; i < booms.length; i++){
                if(booms[i].timeLife == 4){
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, booms[i].x*50, booms[i].y*50, 50, 50, sprite_map, 'FIRE_4');

                }
                if(booms[i].timeLife == 3){
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, booms[i].x*50, booms[i].y*50, 50, 50, sprite_map, 'FIRE_3');

                }
                if(booms[i].timeLife == 2){
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, booms[i].x*50, booms[i].y*50, 50, 50, sprite_map, 'FIRE_2');

                }
                if(booms[i].timeLife == 1){
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, booms[i].x*50, booms[i].y*50, 50, 50, sprite_map, 'FIRE_1');

                }
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