window.onload = () => {

    const server = new Server();

    document.getElementById('move').addEventListener('click', async () => {
        console.log(await server.move(1, 'left'));
    });
};