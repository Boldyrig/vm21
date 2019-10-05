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

    move(id, direction) {
        return this.send('move', { id, direction });
    }

    shoot(id) {
        return this.send('shoot', { id });
    }
}