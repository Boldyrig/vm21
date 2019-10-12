window.onload = () => {

    const server = new Server();

    // запрос на обновление сцены каждые 100 мс
    //setInterval(updateScene, 100);
    async function updateScene () {
        console.log(await server.updateScene());
    }
    
    async function checkEndGame (){
        console.log(await server.checkEndGame());
    };
    
    document.getElementById('move').addEventListener('click', async () => {
        console.log(await server.move(1, 'left'));
    });

    document.getElementById('shoot').addEventListener('click', async () => {
        console.log(await server.shoot(1));
    });

    document.getElementById('loginButton').addEventListener('click', async () => {
        const login = document.getElementById('login').value;
        const password = document.getElementById('password').value;
        if (login && password) {
            const rnd = Math.round(Math.random() * 100000);
            const hash = md5(md5(login + password) + rnd);
            const result = await server.auth(login, hash, rnd);

            console.log(result);
            
        } else {
            console.log('Не хватает данных!');
        }
    });
    checkEndGame();
};