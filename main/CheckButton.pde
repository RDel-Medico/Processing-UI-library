abstract class CheckButton {
  String [] values;
  int nbValue;

  int x;
  int y;
  
  int spaceBetweenLine;

  CheckButton (int posX, int posY, String[] values) {
    this.x = posX;
    this.y = posY;
    this.values = values;
    this.nbValue = values.length;
    this.spaceBetweenLine = 30;
  }
  
  abstract void display();
}

class CheckBox extends CheckButton {
  int boxWidth;
  int boxHeight;

  boolean[] boxSelected;

  int boxColorRed;
  int boxColorGreen;
  int boxColorBlue;
  int boxStrokeColorRed;
  int boxStrokeColorGreen;
  int boxStrokeColorBlue;
  int boxStrokeWidth;

  int valueColorRed;
  int valueColorGreen;
  int valueColorBlue;
  int valueTextWidth;
  
  int checkColorRed;
  int checkColorGreen;
  int checkColorBlue;
  int checkWidth;
  
  boolean [] clicked;

  CheckBox (int posX, int posY, String[] values, int boxWidth, int boxHeight) {
    super(posX, posY, values);
    this.boxWidth = boxWidth;
    this.boxHeight = boxHeight;

    this.boxColorRed = 200;
    this.boxColorGreen = 200;
    this.boxColorBlue = 200;
    this.boxStrokeColorRed = 150;
    this.boxStrokeColorGreen = 150;
    this.boxStrokeColorBlue = 150;
    this.boxStrokeWidth = 1;

    this.valueColorRed = 0;
    this.valueColorGreen = 0;
    this.valueColorBlue = 0;
    this.valueTextWidth = 20;
    
    this.checkColorRed = 0;
    this.checkColorGreen = 222;
    this.checkColorBlue = 0;
    this.checkWidth = 3;
    
    this.boxSelected = new boolean[this.nbValue];
    
    this.clicked = new boolean[this.nbValue];
    
    
    
    for (int i = 0; i < this.nbValue; i++) {
      this.boxSelected[i] = false;
      this.clicked[i] = false;
    }
  }

  void displayCheckBox () {
    stroke(this.boxStrokeColorRed, this.boxStrokeColorGreen, this.boxStrokeColorBlue);
    
    strokeWeight(this.boxStrokeWidth);
    for (int i = 0; i < this.nbValue; i++) {
      if (isMouseHoveringBox(i)) {
        fill(this.boxColorRed - 100, this.boxColorGreen - 100, this.boxColorBlue - 100);
      } else {
        fill(this.boxColorRed, this.boxColorGreen, this.boxColorBlue);
      }
      rect(x, y + i * this.spaceBetweenLine, this.boxWidth, this.boxHeight);
    }
  }

  void displayValue () {
    textAlign(LEFT, CENTER);
    fill(this.valueColorRed, this.valueColorGreen, this.valueColorBlue);
    textSize(this.valueTextWidth);
    for (int i = 0; i < this.nbValue; i++) {
      text(values[i], this.x + this.boxWidth + 20, this.y + i * this.spaceBetweenLine);
    }
  }
  
  void displaySelected() {
    stroke(this.checkColorRed, this.checkColorGreen, this.checkColorBlue);
    strokeWeight(this.checkWidth);
    for (int i = 0; i < this.nbValue; i++) {
      if (boxSelected[i]) {
        line(this.x + 2, this.y + this.spaceBetweenLine * i + this.boxHeight / 2, this.x + this.boxWidth / 2, this.y + this.spaceBetweenLine * i + this.boxHeight - 2);
        line(this.x + this.boxWidth / 2, this.y + this.spaceBetweenLine * i + this.boxHeight - 2,this.x + this.boxWidth - 2, this.y + this.spaceBetweenLine * i + 2);
      }
    }
  }
  
  void updateChecked () {
    for (int i = 0; i < this.nbValue; i++) {
      
      
      
      if (this.isActivated(i) && !this.clicked[i]) {
      this.boxSelected[i] = !this.boxSelected[i];
      this.clicked[i] = true;
    } else if (this.clicked[i] && !this.isActivated(i)) {
      this.clicked[i] = false;
    }
    }
  }

  void display() {
    updateChecked();
    displayCheckBox();
    displaySelected();
    displayValue();
  }

  boolean isMouseHoveringBox (int index) {
    return mouseX > this.x && mouseX < this.x + this.boxWidth && mouseY > this.y + index * this.spaceBetweenLine && mouseY < this.y + index * this.spaceBetweenLine + this.boxHeight;
  }
  
  boolean isActivated (int index) {
    return this.isMouseHoveringBox(index) && mousePressed;
  }
}

class RadioButton extends CheckButton {
  int radius;

  RadioButton (int posX, int posY, String[] values, int radius) {
    super(posX, posY, values);
    this.radius = radius;
  }
  
  void display() {
    
  }
}
