import React from 'react';
class TankConstructor extends React.Component {
    constructor(props) {
        super();
        this.addTankRequest = props.addTankRequest;
        this.update = props.update;
        this.setConstructed = props.setConstructed;
        this.getConstructor = props.getConstructor;
        this.constructor = null;
        this.loadConstructor();
        this.money = props.money;
        this.state = {
            isLoaded: false
        }
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
        let price = 0;
        for(let elem in this.constructor){
            for(let i = 0; i < this.constructor[elem].length; i ++){
                let item = this.constructor[elem][i];
                if(document.getElementById(item.name).checked){
                    params[elem] = item.id;
                    price += item.price ? item.price - 0 : 0;
                }
            }
            if(!params[elem]){
                return false;
            }
        }
        if(this.money >= price){
            params['MONEY'] = this.money;
            return params;
        }
        return false;
    }

    printConstructor(){
        let arr = [];
        const CONSTRUCTOR = this.constructor.CONSTRUCTOR;
        for(let elem in CONSTRUCTOR){
            arr.push(<p>{elem}</p>);
            for(let i = 0; i < CONSTRUCTOR[elem].length; i ++){
                let item = CONSTRUCTOR[elem][i];
                arr.push(<label>
                            <input type='radio' name={elem} id={item.name}></input>
                            <img className='constructorImages' src={require(`../img/${item.image}`)} alt='none' />
                            { item.price ? <span>{item.price}</span> : null }
                        </label>);   
            }
            arr.push(<br />);
        }
        return React.createElement('div', {className: 'tankConstructor'}, arr);
    }

    render() {
        return (<div>
            { this.constructor ? this.printConstructor() : null }
            <button onClick={ () => {
                if(this.buildTank()){
                    this.addTankRequest(this.buildTank());  // Отправляем запрос на сервер для создания нового танка с параметрами из конструктора
                    this.update();
                    this.setConstructed(true);
                }
            }}>Начать игру</button>
            </div>);
    }
}

export default TankConstructor;