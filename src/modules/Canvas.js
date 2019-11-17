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

    drawImageScale(img, x, y, width, height, direction) {
        if(direction){
            let angle = 0;
            let dx = 0;
            let dy = 0;
            switch(direction) {
                case 'up':
                    angle = 0;
                    dx = x;
                    dy = y;
                    break;
                case 'down':
                    angle = Math.PI;
                    dx = x + width;
                    dy = y + height;
                    break;
                case 'left':
                    angle = -Math.PI/2;
                    dx = x;
                    dy = y + height;
                    break;
                case 'right':
                    angle = Math.PI/2;
                    dx = x + width;
                    dy = y;
                    break;
            }
            this.context.translate(dx, dy);
            this.context.rotate(angle);
            this.context.drawImage(img, 0, 0, img.width, img.height, 0, 0, width, height);
            this.context.rotate(-angle);
            this.context.translate(-dx, -dy);
            return;
        }
        this.context.drawImage(img, 0, 0, img.width, img.height, x, y, width, height);
    }

    drawRect() {
        this.context.fillStyle = '#ffffff';
        this.context.rect(10, 10, 100, 100);
        this.context.fill();
    }
}