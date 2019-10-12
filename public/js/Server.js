class Server {

    async send(method, data) {
        let arr = [];
        for (let key in data) {
            arr.push(`${key}=${data[key]}`);
        }
        const response = await fetch(`api/?method=${method}&${arr.join('&')}`);
        const answer = await response.json();
        return (answer && answer.result == 'ok') ? answer.data : answer.error;
    }

    /********************/
    /* Про пользователя */
    /********************/

    auth(login, hash, rnd) {
        return this.send('login', { login, hash, rnd });
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
}