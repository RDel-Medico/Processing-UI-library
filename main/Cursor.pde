class Cursor {

  int x;
  int y;

  int minValue;
  int maxValue;
  int value;
  float valuePercent;

  int width;
  int height;

  boolean centered;

  int barColorRed;
  int barColorGreen;
  int barColorBlue;
  int barStrokeWidth;
  int barStrokeColorRed;
  int barStrokeColorGreen;
  int barStrokeColorBlue;
  
  int selectorColorRed;
  int selectorColorGreen;
  int selectorColorBlue;
  int selectorStrokeWidth;
  int selectorStrokeColorRed;
  int selectorStrokeColorGreen;
  int selectorStrokeColorBlue;
  
  int selectorX;
  int selectorY;
  int selectorRadius;
  
  boolean selectorDragged;


  Cursor (int x, int y, int w, int h, int minValue, int maxValue) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.minValue = minValue;
    this.maxValue = maxValue;
    
    this.barColorRed = 227;
    this.barColorGreen = 227;
    this.barColorBlue = 227;
    this.barStrokeColorRed = 175;
    this.barStrokeColorGreen = 175;
    this.barStrokeColorBlue = 175;
    this.barStrokeWidth = 5;
    
    this.selectorColorRed = 201;
    this.selectorColorGreen = 227;
    this.selectorColorBlue = 255;
    this.selectorStrokeColorRed = 139;
    this.selectorStrokeColorGreen = 196;
    this.selectorStrokeColorBlue = 255;
    this.selectorStrokeWidth = 3;
    
    this.selectorDragged = false;
    
    this.selectorRadius = this.height + 10;

    this.centered = true;
    
    this.selectorX = (int)(this.x + this.valuePercent * this.width - this.width / 2);
    this.selectorY = this.y;
  }

  void displaySelector() {
    fill(this.selectorColorRed, this.selectorColorGreen, this.selectorColorBlue);
    stroke(this.selectorStrokeColorRed, this.selectorStrokeColorGreen, this.selectorStrokeColorBlue);
    strokeWeight(this.selectorStrokeWidth);
    circle(this.selectorX, this.selectorY, this.selectorRadius);
  }

  void displayBar() {
    fill(this.barColorRed, this.barColorGreen, this.barColorBlue);
    stroke(this.barStrokeColorRed, this.barStrokeColorGreen, this.barStrokeColorBlue);
    strokeWeight(this.barStrokeWidth);

    if (this.centered) {
      rect(this.x - this.width/2, this.y - this.height / 2, this.width, this.height);
    } else {
      rect(this.x, this.y, this.width, this.height);
    }
  }
  
  void updateSelector() {
    if (this.centered) {
      this.selectorX = (int)(this.x + this.width * this.valuePercent - this.width / 2);
      this.selectorY = this.y;
    } else {
      this.selectorX = (int)(this.x + this.width * this.valuePercent);
      this.selectorY = this.y + this.height / 2;
    }
    
    this.isSelectorActivated();
    
    if (!mousePressed) {
      this.selectorDragged = false;
    }
    
    if (this.selectorDragged) {
      if (this.centered) {
        if (mouseX < this.x - this.width / 2) {
          this.valuePercent = 0;
        } else if (mouseX > this.x + this.width / 2) {
          this.valuePercent = 1;
        } else {
          this.valuePercent = ((100 * (mouseX - (this.x - this.width / 2))) / this.width);
          this.valuePercent = this.valuePercent / 100;
        }
      } else {
        if (mouseX < this.x) {
          this.valuePercent = 0;
        } else if (mouseX > this.x + this.width) {
          this.valuePercent = 1;
        } else {
          this.valuePercent = ((100 * (mouseX - this.x)) / this.width);
          this.valuePercent = this.valuePercent / 100;
      }
      }
      
      
    }
  }

  void display() {
    this.updateSelector();
    this.displayBar();
    this.displaySelector();
  }
  
  boolean isMouseHoveringSelector () {
    return  distanceTwoPoints(mouseX, mouseY, this.selectorX, this.selectorY) <= this.selectorRadius / 2;
  }
  
  boolean isSelectorActivated () {
    if (mousePressed && this.isMouseHoveringSelector()) {
      this.selectorDragged = true;
      return true;
    }
    return false;
  }
}
