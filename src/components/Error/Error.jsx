import React from 'react'
import './Error.css'

export default class Error extends React.Component {
    constructor(props){
        super();
        this.errors = props.errors();
    }

    printErrors() {
        let arr = [];
        for(let i = 0; i < this.errors.length; i++){
            arr.push(<div id="error">
                        <span>>>{this.errors[i].code}</span><br/>
                        <span>{this.errors[i].text}</span><br/>
                    </div>);
        }
        return React.createElement('div', {className: 'errors'}, arr);
    }

    render(){
        return (
        <div className='Error'>
            {this.printErrors()}
        </div>);
    }
}

