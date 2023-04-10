class Cursor {

  private int x;
  private int y;

  private int minValue;
  private int maxValue;
  private int value;
  private float valuePercent;

  private int width;
  private int height;

  private boolean centered;

  public int barColorRed;
  public int barColorGreen;
  public int barColorBlue;
  private int barStrokeWidth;
  public int barStrokeColorRed;
  public int barStrokeColorGreen;
  public int barStrokeColorBlue;

  public int selectorColorRed;
  public int selectorColorGreen;
  public int selectorColorBlue;
  private int selectorStrokeWidth;
  public int selectorStrokeColorRed;
  public int selectorStrokeColorGreen;
  public int selectorStrokeColorBlue;

  private int selectorX;
  private int selectorY;
  private int selectorRadius;

  private int valueFontSize;
  public int valueFontColorRed;
  public int valueFontColorGreen;
  public int valueFontColorBlue;
  public int valueStrokeColorRed;
  public int valueStrokeColorGreen;
  public int valueStrokeColorBlue;
  private int valueStrokeWidth;
  public int valueBackgroundColorRed;
  public int valueBackgroundColorGreen;
  public int valueBackgroundColorBlue;
  private boolean fontDirty;
  private boolean showValue;


  private String title;
  private int titleFontSize;
  public int titleColorRed;
  public int titleColorGreen;
  public int titleColorBlue;
  private boolean titleTop;
  private boolean showTitle;


  private boolean selectorDragged;


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
    this.showValue = true;

    this.title = title;
    this.titleFontSize = 30;
    this.titleColorRed = 0;
    this.titleColorGreen = 0;
    this.titleColorBlue = 0;
    this.titleTop = false;
    this.showTitle = true;

    this.selectorDragged = false;

    this.selectorRadius = this.height + 10;

    this.centered = false;

    this.selectorX = (int)(this.x + this.valuePercent * this.width - this.width / 2);
    this.selectorY = this.y;
  }

  private void displaySelector() {
    fill(this.selectorColorRed, this.selectorColorGreen, this.selectorColorBlue);
    stroke(this.selectorStrokeColorRed, this.selectorStrokeColorGreen, this.selectorStrokeColorBlue);
    strokeWeight(this.selectorStrokeWidth);
    circle(this.selectorX, this.selectorY, this.selectorRadius);
  }

  private void displayTitle() {

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

  private void displayBar() {
    fill(this.barColorRed, this.barColorGreen, this.barColorBlue);
    stroke(this.barStrokeColorRed, this.barStrokeColorGreen, this.barStrokeColorBlue);
    strokeWeight(this.barStrokeWidth);

    if (this.centered) {
      rect(this.x - this.width/2, this.y - this.height / 2, this.width, this.height);
    } else {
      rect(this.x, this.y, this.width, this.height);
    }
  }

  private void updateValue () {
    this.value = (int)(this.minValue + (this.maxValue - this.minValue) * this.valuePercent);
  }

  private void setValueFontSize() {
    float minWidth = 12/(str(this.value).length()) * 80;


    float minHeight = 12/(textDescent() + textAscent()) * (this.height + 20);
    this.valueFontSize = (int)min(minWidth, minHeight) - 2;
  }

  private void displayValue () {
    fill(this.valueBackgroundColorRed, this.valueBackgroundColorGreen, this.valueBackgroundColorBlue);
    stroke(this.valueStrokeColorRed, this.valueStrokeColorGreen, this.valueStrokeColorBlue);
    strokeWeight(this.valueStrokeWidth);

    if (this.centered) {
      rect(this.x + this.width / 2 + 20, this.y - this.height / 2 - 10, 80, this.height + 20);
    } else {
      rect(this.x + this.width + 20, this.y - 10, 80, this.height + 20);
    }

    fill(this.valueFontColorRed, this.valueFontColorGreen, this.valueFontColorBlue);
    textAlign(CENTER, CENTER);

    this.updateValue();
    if (this.fontDirty) {
      this.setValueFontSize();
      this.fontDirty = false;
    }

    textSize(this.valueFontSize);

    if (this.centered) {
      text(this.value, this.x + this.width / 2 + 60, this.y);
    } else {
      text(this.value, this.x + this.width + 60, this.y + this.height / 2);
    }
  }

  private void updateSelector() {
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

  public void display() {
    this.updateSelector();
    this.displayBar();
    this.displaySelector();
    if (this.showValue) {
      this.displayValue();
    }

    if (this.showTitle) {
      this.displayTitle();
    }
  }

  public boolean isMouseHoveringSelector () {
    return  distanceTwoPoints(mouseX, mouseY, this.selectorX, this.selectorY) <= this.selectorRadius / 2;
  }

  public boolean isSelectorActivated () {
    if (mousePressed && this.isMouseHoveringSelector()) {
      this.selectorDragged = true;
      return true;
    }
    return false;
  }

  public void setX (int x) {
    this.x = x;
  }

  public void setY (int y) {
    this.y = y;
  }

  public void setMinValue (int minValue) {
    this.minValue = minValue;
  }

  public void setMaxValue (int maxValue) {
    this.maxValue = maxValue;
  }

  public void setWidth (int w) {
    this.width = w;
  }

  public void setHeight (int h) {
    this.height = h;
  }

  public void setCentered (boolean centered) {
    this.centered = centered;
  }

  public void setBarColor (int red, int green, int blue) {
    this.barColorRed = red;
    this.barColorGreen = green;
    this.barColorBlue = blue;
  }

  public void setBarColor (int black) {
    this.barColorRed = black;
    this.barColorGreen = black;
    this.barColorBlue = black;
  }

  public void setBarStrokeColor (int red, int green, int blue) {
    this.barStrokeColorRed = red;
    this.barStrokeColorGreen = green;
    this.barStrokeColorBlue = blue;
  }

  public void setBarStrokeColor (int black) {
    this.barStrokeColorRed = black;
    this.barStrokeColorGreen = black;
    this.barStrokeColorBlue = black;
  }

  public void setBarStrokeWidth (int w) {
    this.barStrokeWidth = w;
  }

  public void setSelectorColor (int red, int green, int blue) {
    this.selectorColorRed = red;
    this.selectorColorGreen = green;
    this.selectorColorBlue = blue;
  }

  public void setSelectorColor (int black) {
    this.selectorColorRed = black;
    this.selectorColorGreen = black;
    this.selectorColorBlue = black;
  }

  public void setSelectorStrokeColor (int red, int green, int blue) {
    this.selectorStrokeColorRed = red;
    this.selectorStrokeColorGreen = green;
    this.selectorStrokeColorBlue = blue;
  }

  public void setSelectorStrokeColor (int black) {
    this.selectorStrokeColorRed = black;
    this.selectorStrokeColorGreen = black;
    this.selectorStrokeColorBlue = black;
  }

  public void setSelectorStrokeWidth (int w) {
    this.selectorStrokeWidth = w;
  }

  public void setSelectorRadius (int radius) {
    this.selectorRadius = radius;
  }

  public void setValueFontSize (int size) {
    this.valueFontSize = size;
  }

  public void setValueFontColor (int red, int green, int blue) {
    this.valueFontColorRed = red;
    this.valueFontColorGreen = green;
    this.valueFontColorBlue = blue;
  }

  public void setValueFontColor (int black) {
    this.valueFontColorRed = black;
    this.valueFontColorGreen = black;
    this.valueFontColorBlue = black;
  }

  public void setValueStrokeColor (int red, int green, int blue) {
    this.valueStrokeColorRed = red;
    this.valueStrokeColorGreen = green;
    this.valueStrokeColorBlue = blue;
  }

  public void setValueStrokeColor (int black) {
    this.valueStrokeColorRed = black;
    this.valueStrokeColorGreen = black;
    this.valueStrokeColorBlue = black;
  }

  public void setValueBackgroundColor (int red, int green, int  blue) {
    this.valueBackgroundColorRed = red;
    this.valueBackgroundColorGreen = green;
    this.valueBackgroundColorBlue = blue;
  }

  public void setValueBackgroundColor (int black) {
    this.valueBackgroundColorRed = black;
    this.valueBackgroundColorGreen = black;
    this.valueBackgroundColorBlue = black;
  }

  public void setValueStrokeWidth (int w) {
    this.valueStrokeWidth = w;
  }

  public void setTitle (String title) {
    this.title = title;
  }

  public void setColorTitle (int red, int green, int blue) {
    this.titleColorRed = red;
    this.titleColorGreen = green;
    this.titleColorBlue = blue;
  }

  public void setColorTitle (int black) {
    this.titleColorRed = black;
    this.titleColorGreen = black;
    this.titleColorBlue = black;
  }

  public void setTitleFontSize (int size) {
    this.titleFontSize = size;
  }

  public void setShowValue (boolean show) {
    this.showValue = show;
  }

  public void setShowTitle (boolean show) {
    this.showTitle = show;
  }

  public int getX () {
    return this.x;
  }

  public int getY () {
    return this.y;
  }

  public int getMinValue () {
    return this.minValue;
  }

  public int getMaxValue () {
    return this.maxValue;
  }

  public int getValue () {
    return this.value;
  }

  public float getValuePercent () {
    return this.valuePercent;
  }

  public boolean isCentered () {
    return this.centered;
  }

  public int getWidth() {
    return this.width;
  }

  public int getHeight() {
    return this.height;
  }

  public int getSelectorRadius() {
    return this.selectorRadius;
  }

  public int getValueFontSize() {
    return this.valueFontSize;
  }

  public int getBarStrokeWidth () {
    return this.barStrokeWidth;
  }

  public int getSelectorBarStrokeWidth () {
    return this.selectorStrokeWidth;
  }

  public int getValueStrokeWidth () {
    return this.valueStrokeWidth;
  }

  public String getTitle () {
    return this.title;
  }

  public int getTitleFontSize () {
    return this.titleFontSize;
  }

  public boolean isValueDisplayed () {
    return this.showValue;
  }

  public boolean isTitleDisplayed () {
    return this.showTitle;
  }

  public boolean isTitleOnTop () {
    return this.titleTop;
  }

  public boolean isTitleOnLeft () {
    return !this.titleTop;
  }
}
