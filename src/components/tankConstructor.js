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
        this.setErrors = props.setErrors;
        this.state = {
            isLoaded: false
        }
    }

    async loadConstructor(){
        this.constructor = await this.getConstructor();
        if(this.constructor) {
            this.setState({ isLoaded: true });
        }
    }

    // Берем собранный танк
    buildTank() {
        let params = {};
        let price = 0;
        const CONSTRUCTOR = this.constructor.CONSTRUCTOR;
        for(let elem in CONSTRUCTOR){
            for(let i = 0; i < CONSTRUCTOR[elem].length; i++){
                let item = CONSTRUCTOR[elem][i];
                if(document.getElementById(item.name).checked){
                    params[elem] = item.id;
                    price += item.price ? item.price - 0 : 0;
                }
            }
            if(!params[elem]){
                this.setErrors({
                    code: 500,
                    text: 'Танк собран не полностью'
                });
                return false;
            }
        }
        let defaultMoney = this.constructor.DEFAULT_MONEY;
        this.money = (this.money >= defaultMoney) ? this.money : defaultMoney;
        if(this.money >= price){
            return params;
        } else {
            this.setErrors({
                code: 500,
                text: 'Недостаточно денег'
            });
        }
        return false;
    }

    printConstructor(){
        let arr = [];
        const CONSTRUCTOR = this.constructor.CONSTRUCTOR;
        for(let elem in CONSTRUCTOR){
            arr.push(<p key={elem.toString()}>--{elem}--</p>);
            for(let i = 0; i < CONSTRUCTOR[elem].length; i++){
                let item = CONSTRUCTOR[elem][i];
                arr.push(<label key={item.name.toString()}>
                            <input key={item.name.toString() + i} type='radio' name={elem} id={item.name}></input>
                            <img key={item.name.toString() + "_img"} className='constructorImages' src={require(`../img/${item.image}`)} alt='none' />
                            { item.price ? <span key={item.name.toString() + "_price"}>{item.price}</span> : null }
                        </label>);
            }
            arr.push(<br />);
        }
        return React.createElement('div', {className: 'tankConstructor'}, arr);
    }

    render() {
        return (<div key='tankConstructor'>
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