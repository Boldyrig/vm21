export default class Server {

    HOST = 'http://vm21/api/?';
    token = null;

    async send(method, data) {
        let arr = [];
        for (let key in data) {
            arr.push(`${key}=${data[key]}`);
        }
        if (this.token) {
            arr.push(`token=${this.token}`);
        }
        const response = await fetch(`${this.HOST}method=${method}&${arr.join('&')}`);
        const answer = await response.json();
        return (answer && answer.result === 'ok') ? answer.data : false;
    }

    /********************/
    /* Про пользователя */
    /********************/

    async auth(data) {
        const result = await this.send('login', data);
        if (result && result.token) {
            this.token = result.token;
        }
        return result;
    }

    logout() {
        return this.send('logout');
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

    async getConstructor() {
        const constructor = await this.send('getConstructor');
        return constructor;
    }

    joinGame(tankParams) {
        return this.send('joinGame', { tankParams });
    }
}