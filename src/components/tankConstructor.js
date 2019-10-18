import React from 'react';
class TankConstructor extends React.Component {

    constructor(props) {
        super();
        this.imgDirs = {
            hull_1 : require('../img/Tanks/HULL_A_1.png'),
            hull_2 : require('../img/Tanks/HULL_B_1.png'),
            gun_1 : require('../img/Tanks/GUN_A_1.png'),
            gun_2 : require('../img/Tanks/GUN_B_1.png'),
            shasshi_1 : require('../img/Tanks/chassis_A.png'),
            shasshi_2 : require('../img/Tanks/chassis_B.png')
        }
    }

    render() {
        return (
            <div className="tankConstructor">
                <h1>Конструктор танка</h1>
                <p>Тип корпуса</p>
                
                <label>
                    <input type='radio' name = 'hull' value = 'HULL_LIGHT' defaultChecked></input>
                    <img class = 'constructorImages' src = {this.imgDirs.hull_1} alt = 'hull1' />
                    </label>
                <label>
                    <input type='radio' name = 'hull' value = 'HULL_HARD'></input>
                    <img class = 'constructorImages' src = {this.imgDirs.hull_2} alt = 'hull2' />
                </label>
                <br />
                <p>Тип пушки</p>
                <label>
                    <input type='radio' name = 'gun' value = 'GUN_LIGHT' defaultChecked></input>
                    <img class = 'constructorImages' src = {this.imgDirs.gun_2} alt = 'gun1' />
                </label>
                <label>
                    <input type='radio' name = 'gun' value = 'GUN_HARD'></input>
                    <img class = 'constructorImages' src = {this.imgDirs.gun_1} alt = 'gun2' />
                </label>
                <p>Тип шасси</p>
                <label>
                    <input type='radio' name = 'shasshi' value = 'CATERPILLAR' defaultChecked></input>
                    <img class = 'constructorImages' src = {this.imgDirs.shasshi_2} alt = 'shasshis2' />
                </label>
                <label>
                    <input type='radio' name = 'shasshi' value = 'WHEELS'></input>
                    <img class = 'constructorImages' src = {this.imgDirs.shasshi_1} alt = 'shasshis1' />
                </label><br />
            </div>
        );
    }
}

export default TankConstructor;