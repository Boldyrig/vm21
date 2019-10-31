import React from 'react';
class TankConstructor extends React.Component {
    constructor(props) {
        super();
        this.joinRequest = props.joinRequest;
        this.update = props.update;
        this.setConstructed = props.setConstructed;
        this.getConstructor = props.getConstructor;
        this.constructor = null;
        this.loadConstructor();
        //this.getConstructor().then(result => {this.constructor = result; this.setState({isLoaded: true})});
        this.state = {
            isLoaded: false
        }
        // this.imgDirs = {
        //     hull_1 : require('../img/Tanks/HULL_A_1.png'),
        //     hull_2 : require('../img/Tanks/HULL_B_1.png'),
        //     gun_1 : require('../img/Tanks/GUN_A_1.png'),
        //     gun_2 : require('../img/Tanks/GUN_B_1.png'),
        //     shasshi_1 : require('../img/Tanks/chassis_A.png'),
        //     shasshi_2 : require('../img/Tanks/chassis_B.png'),
        //     team_red : require('../img/Team/red.png'),
        //     team_blue : require('../img/Team/blue.png')
        // }
    }

    async loadConstructor(){
        this.constructor = await this.getConstructor();
        if(this.constructor) {
            this.setState({ isLoaded: true});
        }
    }

    // Берем собранный танк
    buildTank() {
        let params = {};
        for(let elem in this.constructor){
            for(let i = 0; i < this.constructor[elem].length; i ++){
                let item = this.constructor[elem][i];
                if(document.getElementById(item.name).checked){
                    params[elem] = item.name;
                }
            }
            if(!params[elem]){
                return false;
            }
        }
        return params;
        // if(document.getElementById('TEAM_RED').checked){ var team =  document.getElementsByName('team')[0].value; }
        // if(document.getElementById('TEAM_BLUE').checked){ var team =  document.getElementsByName('team')[1].value; }

        // if (document.getElementById('HULL_LIGHT').checked) { var hull = document.getElementsByName('hull')[0].value; }
        // if (document.getElementById('HULL_HARD').checked) { var hull = document.getElementsByName('hull')[1].value; }
        
        // if (document.getElementById('GUN_LIGHT').checked) { var gun = document.getElementsByName('gun')[0].value; }
        // if (document.getElementById('GUN_HARD').checked) { var gun = document.getElementsByName('gun')[1].value; }

        // if (document.getElementById('CATERPILLAR').checked) { var shasshi = document.getElementsByName('shasshi')[0].value; }
        // if (document.getElementById('WHEELS').checked) { var shasshi = document.getElementsByName('shasshi')[1].value; }

        // if (team !== undefined && hull !== undefined && gun !== undefined && shasshi !== undefined){   
        //     return  {
        //         "team": team,
        //         "hull": hull,
        //         "gun":  gun,
        //         "shasshi": shasshi
        //     };
        // } else {
        //     return false;
        // }
    }

    printConstructor(){
        let arr = [];
        for(let elem in this.constructor){
            arr.push(<p>{elem}</p>);
            for(let i = 0; i < this.constructor[elem].length; i ++){
                let item = this.constructor[elem][i];
                arr.push(<label>
                            <input type='radio' name={elem} id={item.name}></input>
                            <img className='constructorImages' src={require(`../img/${item.image}`)} alt='none' />
                        </label>);   
            }
            arr.push(<br />);
        }
        return React.createElement('div', {className: 'tankConstructor'}, arr);
    }

    render() {
        return (<div>
            {this.constructor ? this.printConstructor() : null}
            <button onClick={ () => {
                if(this.buildTank()){
                    this.joinRequest(this.buildTank());  // Отправляем запрос на сервер для создания нового танка с параметрами из конструктора
                    this.update();
                    this.setConstructed(true);
                }
            }}>Начать игру</button>
            </div>);
        // return  (
        //     <div>
        //     <div className="tankConstructor">
        //         <h1>Выбор команды</h1>
        //     <label>
        //         <input type='radio' name='team' id= 'TEAM_RED' value = 'TEAM_RED' ></input>
        //         <img className = 'constructorImages' src = {this.imgDirs.team_red} alt = 'teamred' />
        //     </label>
        //     <label>
        //         <input type='radio' name='team' id= 'TEAM_BLUE' value = 'TEAM_BLUE' ></input>
        //         <img className = 'constructorImages' src = {this.imgDirs.team_blue} alt = 'teamred' />
        //     </label> <br/>
        //         <h1>Конструктор танка</h1>
        //         <p>Тип корпуса</p>
                
        //         <label>
        //             <input type='radio' name='hull' id= 'HULL_LIGHT' value = 'HULL_LIGHT' ></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.hull_1} alt = 'hull1' />
        //             <span>{this.arms ? this.arms.HULL_TYPES[0].price : 0}</span>
        //             </label>
        //         <label>
        //             <input type='radio' name='hull' id= 'HULL_HARD' value = 'HULL_HARD'></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.hull_2} alt = 'hull2' />
        //             <span>{this.arms ? this.arms.HULL_TYPES[1].price : 0}</span>
        //         </label>
        //         <br />
        //         <p>Тип пушки</p>
        //         <label>
        //             <input type='radio' name='gun' id= 'GUN_LIGHT' value = 'GUN_LIGHT' ></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.gun_1} alt = 'gun1' />
        //             <span>{this.arms ? this.arms.GUN_TYPES[0].price : 0}</span>
        //         </label>
        //         <label>
        //             <input type='radio' name='gun' id= 'GUN_HARD' value = 'GUN_HARD'></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.gun_2} alt = 'gun2' />
        //             <span>{this.arms ? this.arms.GUN_TYPES[1].price : 0}</span>
        //         </label>
        //         <p>Тип шасси</p>
        //         <label>
        //             <input type='radio' name='shasshi' id= 'CATERPILLAR' value = 'CATERPILLAR'></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.shasshi_2} alt = 'shasshis2' />
        //             <span>{this.arms ? this.arms.SHASSIS_TYPE[1].price : 0}</span>
        //         </label>
        //         <label>
        //             <input type='radio' name='shasshi' id= 'WHEELS' value = 'WHEELS'></input>
        //             <img className = 'constructorImages' src = {this.imgDirs.shasshi_1} alt = 'shasshis1' />
        //             <span>{this.arms ? this.arms.SHASSIS_TYPE[0].price : 0}</span>
        //         </label><br />
        //     </div>
        //     <button onClick={ () => {
        //         if(this.buildTank()){
        //             this.joinRequest(this.buildTank());  // Отправляем запрос на сервер для создания нового танка с параметрами из конструктора
        //             this.update();
        //             this.setConstructed(true);
        //         }
        //     }}>Начать игру</button>
        //     </div>
        // );
    }
}

export default TankConstructor;