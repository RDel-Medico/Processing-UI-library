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

  int valueFontSize;
  int valueFontColorRed;
  int valueFontColorGreen;
  int valueFontColorBlue;
  int valueStrokeColorRed;
  int valueStrokeColorGreen;
  int valueStrokeColorBlue;
  int valueStrokeWidth;
  int valueBackgroundColorRed;
  int valueBackgroundColorGreen;
  int valueBackgroundColorBlue;
  boolean fontDirty;


  String title;
  int titleFontSize;
  int titleColorRed;
  int titleColorGreen;
  int titleColorBlue;
  boolean titleTop;


  boolean selectorDragged;


  Cursor (int x, int y, int w, int h, int minValue, int maxValue, String title) {
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


    this.valueFontColorRed = 0;
    this.valueFontColorGreen = 0;
    this.valueFontColorBlue = 0;
    this.valueStrokeColorRed = 175;
    this.valueStrokeColorGreen = 175;
    this.valueStrokeColorBlue = 175;
    this.valueStrokeWidth = 5;
    this.valueBackgroundColorRed = 227;
    this.valueBackgroundColorGreen = 227;
    this.valueBackgroundColorBlue = 227;
    this.fontDirty = true;

    this.title = title;
    this.titleFontSize = 30;
    this.titleColorRed = 0;
    this.titleColorGreen = 0;
    this.titleColorBlue = 0;
    this.titleTop = false;

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

  void displayTitle() {

    fill(titleColorRed, titleColorGreen, titleColorBlue);
    textSize(titleFontSize);
    textAlign(CENTER);


    if (this.titleTop) {

      if (this.centered) {
        text(this.title, this.x, this.y - this.height / 2 - 30);
      } else {
        text(this.title, this.x + this.width / 2, this.y - 30);
      }
    } else {
      if (this.centered) {
        text(this.title, this.x - this.width / 2 - textWidth(this.title) + 20, this.y + 10);
      } else {
        text(this.title, this.x - textWidth(this.title) + 20, this.y + this.height / 2 + 10);
      }
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

  void updateValue () {
    this.value = (int)(this.minValue + this.maxValue * this.valuePercent);
  }

  void setValueFontSize() {
    float minWidth = 12/(str(this.value).length()) * 80;


    float minHeight = 12/(textDescent() + textAscent()) * (this.height + 20);
    println(minHeight);
    this.valueFontSize = (int)min(minWidth, minHeight) - 2;
  }

  void displayValue () {
    fill(this.valueBackgroundColorRed, this.valueBackgroundColorGreen, this.valueBackgroundColorBlue);
    stroke(this.valueStrokeColorRed, this.valueStrokeColorGreen, this.valueStrokeColorBlue);
    strokeWeight(this.valueStrokeWidth);

    if (this.centered) {
      rect(this.x + this.width / 2 + 20, this.y - this.height / 2 - 10, 80, this.height + 20);
    } else {
      rect(this.x + this.width + 20, this.y - 10, 80, this.height + 20);
    }

    fill(this.valueFontColorRed, this.valueFontColorGreen, this.valueFontColorBlue);
    textAlign(CENTER);

    this.updateValue();
    if (this.fontDirty) {
      this.setValueFontSize();
      this.fontDirty = false;
    }

    textSize(this.valueFontSize);

    if (this.centered) {
      text(this.value, this.x + this.width / 2 + 60, this.y + 10);
    } else {
      text(this.value, this.x + this.width + 60, this.y + this.height / 2 + 10);
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
    this.displayValue();
    this.displayTitle();
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
