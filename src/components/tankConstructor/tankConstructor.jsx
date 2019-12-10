import React from 'react'
import './tankConstructor.css'

class TankConstructor extends React.Component {
    constructor(props) {
        super();
        this.addTankRequest = props.addTankRequest;
        this.setConstructed = props.setConstructed;
        this.getConstructor = props.getConstructor;
        this.constructorCB = props.constructorCB;
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
            this.constructorCB(this.constructor);
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
            if (elem === 'NUKE') 
                continue;
            if(!params[elem]){
                this.setErrors({
                    code: 500,
                    text: 'Танк собран не полностью'
                });
                return false;
            }
        }
        let defaultMoney = this.constructor.DEFAULT_MONEY;
        
        this.money = (this.money >= defaultMoney - 0) ? this.money : defaultMoney;
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
            arr.push(<div className='name__type'><p key={elem.toString()}>--{elem}--</p></div>);
            for(let i = 0; i < CONSTRUCTOR[elem].length; i++){
                let item = CONSTRUCTOR[elem][i];
                arr.push(<div className='type'><label key={item.name.toString()}>
                            <input key={item.name.toString() + i} type='radio' name={elem} id={item.name}></input>
                            <img key={item.name.toString() + "_img"} className='constructorImages' src={require(`../../assets/img/${item.image}`)} alt='none' />
                            { item.price ? <div className='cost'><span key={item.name.toString() + "_price"}>{item.price}</span></div> : null }
                        </label></div>);
            }
            arr.push(<br />);
        }
        return React.createElement('div', {className: 'tankConstructor'}, arr);
    }

    render() {
        return (<div key='tankConstructor'>
            { this.constructor ? this.printConstructor() : null }
            <div className='menu__btn'><div className='start__btn' onClick={ () => {
                const tankParams = this.buildTank();
                if (tankParams) {
                    this.addTankRequest(tankParams);  // Отправляем запрос на сервер для создания нового танка с параметрами из конструктора
                    this.setConstructed(true);
                }
            }}><a>Start</a></div></div>
            </div>);
    }
}
export default TankConstructor;