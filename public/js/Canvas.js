class Canvas {
    constructor(options) {
    options = (options instanceof Object) ? options : {};
    if (options.id) {
        this.canvas = document.getElementById(options.id);
    } else {
        this.canvas = document.createElement('canvas');
        document.querySelector('body').appendChild(this.canvas);
    }
    this.context = this.canvas.getContext('2d');
    //Настройки размера окна
        this.canvas.width = options.width || 300;
        this.canvas.height = options.height || 300;
    }
    //Очистить экран
    clear() {
        this.vContext.fillStyle = '#eeeeee';
        this.vContext.fillRect(0, 0, this.canvas.width, this.canvas.height);
    }
}