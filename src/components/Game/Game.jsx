import React from 'react'
import Canvas from '../modules/Canvas'
import TankConstructor from '../tankConstructor/tankConstructor'
import './Game.css'

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
        this.boomNuke = props.boomNuke;
        this.state = {
            isConstructed: false,
            money: this.appState.money
        }
        // спрайты (картинки)
        this.SPRITE = {
            SPRITE_MAP: new window.Image(),
        };

        this.SPRITE.SPRITE_MAP.src = require('../../assets/img/Map/map_sprite.png');

        this.updateRequest(scene => {
            if (scene && (scene.die || scene.gameover)) {
                this.stopRequest(); // stop update scene
                alert("Ты подох"); // write: 'Ты подох!!!'
                this.setConstructed(false); // go to constructor
            } else {
                this.renderScene(scene);
            }
        });

        window.document.onkeydown = event => {
            switch (event.keyCode) {
                case 65: this.move('left'); break;//a
                case 37: this.move('left'); break;//стрелка влево
                case 68: this.move('right'); break;//d
                case 39: this.move('right'); break;//стрелка вправо
                case 87: this.move('up'); break;//w
                case 38: this.move('up'); break;//стрелка вверх
                case 83: this.move('down'); break;//s
                case 40: this.move('down'); break;//стрелка вниз
                case 32: this.shoot(); break;
                case 78: this.boomNuke(); break; //бомбануть
            }
        }
    }

    setConstructed(val) {
        this.setState({isConstructed: val});
    }

    componentDidUpdate() {
        this.canvas = new Canvas({ id: 'canvas' });
    }

    constructorCB(constructor){
        this.constructor = constructor;
    }

    renderScene(scene) {
        this.canvas.clear();
        if(scene.userMoney != this.state.money) this.setState({ money:scene.userMoney });
        const field = scene.field;
        const buildings = scene.buildings;
        const bullets = scene.bullets;
        const tanks = scene.tanks;
        const booms = scene.booms;
        const objects = scene.objects;
        const users = scene.users;
        const battle = scene.battle;
        let user = null;
        let tank = null;
        const hullTypes = this.constructor.CONSTRUCTOR.HULL_TYPE;
        const spriteMap = scene.spriteMap;
        let sprite_map = {};
        for(let i = 0; i < spriteMap.length; i++){
            sprite_map[spriteMap[i].name] = spriteMap[i];
        }
        for(let i = 0; i < users.length; i ++) {//взять текущего юзера
            if(users[i].token == this.appState.token) user = users[i];
        }
        for(let i = 0; i < tanks.length; i ++) {//взять танк текущего юзера
            if(tanks[i].user_id == user.id) tank = tanks[i];
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
            
            if(buildings[i].team == tank.team){//отобразить здоровье своей базы
                let maxValue = battle.healthBase;
                let currentValue = buildings[i].hp;
                let value = currentValue / maxValue * 100;
                this.canvas.drawRect(buildings[i].x * 50, buildings[i].y * 50, 100, 10, '#ffffff');//maxHealth
                this.canvas.drawRect(buildings[i].x * 50, buildings[i].y * 50, value, 10, '#ff0000');//currentHealth
            }
        }
        for(let i = 0; i < objects.length; i ++) {
            this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, objects[i].x*50, objects[i].y*50, 50, 50, sprite_map, 'LOOT');
        }
        for (let i = 0; i < tanks.length; i++) {
            if(tanks[i]){
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
                for(let j = 0; j < users.length; j++) {
                    if(tanks[i].user_id == users[j].id) {
                        this.canvas.drawText(users[j].login, tanks[i].x * 50, tanks[i].y * 50, '#ffffff');//login
                    }
                    for(let hull in hullTypes){
                        if(hullTypes[hull].id == tanks[i].hullType){
                            let maxValue = hullTypes[hull].hp;
                            let currentValue = tanks[i].hp;
                            let value = currentValue / maxValue * 50;
                            this.canvas.drawRect(tanks[i].x * 50, tanks[i].y * 50, 50, 10, '#ffffff');//maxHealth
                            this.canvas.drawRect(tanks[i].x * 50, tanks[i].y * 50, value, 10, '#ff0000');//currentHealth
                        }
                    }
                }
            } else if (!tanks[i]) {
                continue;   
            }
            for(let i = 0; i < bullets.length; i ++){
                if(bullets[i].type == 1){
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, sprite_map, 'BULLET_LIGHT', bullets[i].direction);
                } else {
                    this.canvas.drawImageFromSpriteMap(this.SPRITE.SPRITE_MAP, bullets[i].x*50, bullets[i].y*50, 50, 50, sprite_map, 'BULLET_HEAVY', bullets[i].direction);
                }
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

    updateHealth(curValue, maxValue) {
        let health = document.getElementById('cur_health');
        let value = maxValue / 100 * curValue;
        health.style = `width: ${value}%`;
    }

    logout() {
        this.setAuth(false);
    }

    render() {
        return (
            <div className="game">
                <div id='userInfo'>
                    <span>Money: </span>{this.state.money}<span> rub</span><br/>
                    <span>Login: </span>{this.appState.login}<br/>
                </div>
                {this.state.isConstructed
                 ? <canvas id='canvas'></canvas>
                 : <TankConstructor 
                        addTankRequest = { (data) => this.addTankRequest(data)} 
                        setConstructed = { (val) => this.setConstructed(val)}
                        getConstructor = {() => this.getConstructor()}
                        money = {this.appState.money}
                        setErrors = {this.setErrors}
                        constructorCB = {constructor => this.constructorCB(constructor)}/>
                }
                <div className='menu__btn' onClick={ 
                    () => {
                        this.logout();
                        this.setConstructed(false);
                }}><div className='exit__btn'><a>Exit</a></div></div><br/>
            </div>
        );
    }
}