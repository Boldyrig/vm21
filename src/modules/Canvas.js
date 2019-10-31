export default class Canvas {
    constructor(options) {
        options = (options instanceof Object) ? options : {};
        if (options.id) {
            this.canvas = document.getElementById(options.id);
        } else {
            //this.canvas = document.createElement('canvas');
            //document.getElementsByClassName('game')[0].appendChild(this.canvas);
        }
        if(this.canvas){
            this.context = this.canvas.getContext('2d');
            //Настройки размера окна
            this.canvas.width = options.width || 500;
            this.canvas.height = options.height || 500;
        }
    }

    //Очистить экран
    clear() {
        this.context.fillStyle = '#eeeeee';
        this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
    }

    //нарисовать изображение
    drawImage(img, x, y) {
        this.context.drawImage(img, x, y);
    }

    drawImageScale(img, x, y, width, height) {
        this.context.drawImage(img, 0, 0, img.width, img.height, x, y, width, height);
    }

    drawRect() {
        this.context.fillStyle = '#ffffff';
        this.context.rect(10, 10, 100, 100);
        this.context.fill();
    }
}