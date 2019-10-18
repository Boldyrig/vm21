export default class Server {

    HOST = 'http://vm21/api/?';

    async send(method, data) {
        let arr = [];
        for (let key in data) {
            arr.push(`${key}=${data[key]}`);
        }
        const response = await fetch(`${this.HOST}method=${method}&${arr.join('&')}`);
        const answer = await response.json();
        return (answer && answer.result === 'ok') ? answer.data : false;
    }

    /********************/
    /* Про пользователя */
    /********************/

    async auth(data) {
        return this.send('login', data);
    }

    /************/
    /* Про игру */
    /************/

    move(id, direction) {
        return this.send('move', { id, direction });
    }

    checkEndGame() {
        return this.send('checkEndGame',{});
    }

    shoot(id) {
        return this.send('shoot', { id });
    }

    updateScene() {
        return this.send('update', {});
    }

    joinGame(tankParams) {
        return this.send('joinGame', tankParams);
    }
}