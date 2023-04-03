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
  
  int selectorRadius;


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
    
    this.selectorRadius = this.height + 10;

    this.centered = false;
  }

  void displaySelector() {
    fill(this.selectorColorRed, this.selectorColorGreen, this.selectorColorBlue);
    stroke(this.selectorStrokeColorRed, this.selectorStrokeColorGreen, this.selectorStrokeColorBlue);
    strokeWeight(this.selectorStrokeWidth);
    if (this.centered) {
      circle(this.x + this.valuePercent * this.width - this.width / 2, y, this.selectorRadius);
    } else {
      circle(this.x + this.valuePercent * this.width, y + height/2, this.selectorRadius);
    }
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

  void display() {
    this.displayBar();
    this.displaySelector();
  }
}
