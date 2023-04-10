abstract class CheckButton {
  private String [] values;
  private int nbValue;

  private int x;
  private int y;

  private int spaceBetweenLine;

  public int valueColorRed;
  public int valueColorGreen;
  public int valueColorBlue;
  private int valueTextWidth;

  private boolean [] clicked;

  CheckButton (int posX, int posY, String[] values) {
    this.x = posX;
    this.y = posY;
    this.values = values;
    this.nbValue = values.length;
    this.spaceBetweenLine = 30;

    this.valueColorRed = 0;
    this.valueColorGreen = 0;
    this.valueColorBlue = 0;
    this.valueTextWidth = 20;

    this.clicked = new boolean[this.nbValue];

    for (int i = 0; i < this.nbValue; i++) {
      this.clicked[i] = false;
    }
  }

  public abstract void display();

  public String [] getValues () {
    return this.values;
  }

  public int getNbValue () {
    return this.nbValue;
  }

  public int getX () {
    return this.x;
  }

  public int getY () {
    return this.y;
  }

  public int getSpaceBetweenLine () {
    return this.spaceBetweenLine;
  }

  public int getValueTextWidth () {
    return this.valueTextWidth;
  }

  public boolean [] getButtonClicked () {
    return this.clicked;
  }

  public void addValue (String val) {
    this.values = (String[])append(this.values, val);
    this.nbValue++;
  }

  public void setX (int x) {
    this.x = x;
  }

  public void setY (int y) {
    this.y = y;
  }

  public void setSpaceBetweenLine (int spaceBetweenLine) {
    this.spaceBetweenLine = spaceBetweenLine;
  }

  public void setValueColor (int red, int green, int blue) {
    this.valueColorRed = red;
    this.valueColorGreen = green;
    this.valueColorBlue = blue;
  }

  public void setValueColor (int black) {
    this.valueColorRed = black;
    this.valueColorGreen = black;
    this.valueColorBlue = black;
  }

  public void setValueTextWidth (int w) {
    this.valueTextWidth = w;
  }

  public void setClicked (boolean [] clicked) {
    if (this.nbValue == clicked.length) {
      this.clicked = clicked;
    } else {
      println("The size of the tab must be the numbers of value");
    }
  }
}


class CheckBox extends CheckButton {
  private int boxWidth;
  private int boxHeight;

  private boolean[] boxSelected;

  public int boxColorRed;
  public int boxColorGreen;
  public int boxColorBlue;
  public int boxStrokeColorRed;
  public int boxStrokeColorGreen;
  public int boxStrokeColorBlue;
  private int boxStrokeWidth;



  public int checkColorRed;
  public int checkColorGreen;
  public int checkColorBlue;
  private int checkWidth;

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

    this.checkColorRed = 0;
    this.checkColorGreen = 222;
    this.checkColorBlue = 0;
    this.checkWidth = 3;

    this.boxSelected = new boolean[this.getNbValue()];



    for (int i = 0; i < this.getNbValue(); i++) {
      this.boxSelected[i] = false;
    }
  }

  private void displayCheckBox () {
    stroke(this.boxStrokeColorRed, this.boxStrokeColorGreen, this.boxStrokeColorBlue);

    strokeWeight(this.boxStrokeWidth);
    for (int i = 0; i < this.getNbValue(); i++) {
      if (isMouseHoveringBox(i)) {
        fill(this.boxColorRed - 100, this.boxColorGreen - 100, this.boxColorBlue - 100);
      } else {
        fill(this.boxColorRed, this.boxColorGreen, this.boxColorBlue);
      }
      rect(getX(), getY() + i * this.getSpaceBetweenLine(), this.boxWidth, this.boxHeight);
    }
  }

  private void displayValue () {
    textAlign(LEFT, CENTER);
    fill(this.valueColorRed, this.valueColorGreen, this.valueColorBlue);
    textSize(this.getValueTextWidth());
    for (int i = 0; i < this.getNbValue(); i++) {
      text(getValues()[i], this.getX() + this.boxWidth + 20, this.getY() + i * this.getSpaceBetweenLine());
    }
  }

  private void displaySelected() {
    stroke(this.checkColorRed, this.checkColorGreen, this.checkColorBlue);
    strokeWeight(this.checkWidth);
    for (int i = 0; i < this.getNbValue(); i++) {
      if (boxSelected[i]) {
        line(this.getX() + 2, this.getY() + this.getSpaceBetweenLine() * i + this.boxHeight / 2, this.getX() + this.boxWidth / 2, this.getY() + this.getSpaceBetweenLine() * i + this.boxHeight - 2);
        line(this.getX() + this.boxWidth / 2, this.getY() + this.getSpaceBetweenLine() * i + this.boxHeight - 2, this.getX() + this.boxWidth - 2, this.getY() + this.getSpaceBetweenLine() * i + 2);
      }
    }
  }

  public void updateChecked () {
    for (int i = 0; i < this.getNbValue(); i++) {
      if (this.isActivated(i) && !this.getButtonClicked()[i]) {
        this.boxSelected[i] = !this.boxSelected[i];
        this.getButtonClicked()[i] = true;
      } else if (this.getButtonClicked()[i] && !this.isActivated(i)) {
        this.getButtonClicked()[i] = false;
      }
    }
  }

  public void display() {
    updateChecked();
    displayCheckBox();
    displaySelected();
    displayValue();
  }

  public boolean isMouseHoveringBox (int index) {
    return mouseX > this.getX() && mouseX < this.getX() + this.boxWidth && mouseY > this.getY() + index * this.getSpaceBetweenLine() && mouseY < this.getY() + index * this.getSpaceBetweenLine() + this.boxHeight;
  }

  public boolean isActivated (int index) {
    return this.isMouseHoveringBox(index) && mousePressed;
  }

  public int getBoxWidth () {
    return this.boxWidth;
  }

  public int getBoxHeight () {
    return this.boxHeight;
  }

  public boolean [] getBoxSelected () {
    return this.boxSelected;
  }

  public int getBoxStrokeWidth () {
    return this.boxStrokeWidth;
  }

  public int getCheckWidth () {
    return this.checkWidth;
  }

  public void setBoxWidth (int w) {
    this.boxWidth = w;
  }

  public void setBoxHeight (int h) {
    this.boxHeight = h;
  }

  public void setBoxColor (int red, int green, int blue) {
    this.boxColorRed = red;
    this.boxColorGreen = green;
    this.boxColorBlue = blue;
  }

  public void setBoxColor (int black) {
    this.boxColorRed = black;
    this.boxColorGreen = black;
    this.boxColorBlue = black;
  }

  public void setBoxStrokeColorRed (int red, int green, int blue) {
    this.boxStrokeColorRed = red;
    this.boxStrokeColorGreen = green;
    this.boxStrokeColorBlue = blue;
  }

  public void setBoxStrokeColorRed (int black) {
    this.boxStrokeColorRed = black;
    this.boxStrokeColorGreen = black;
    this.boxStrokeColorBlue = black;
  }

  public void setBoxStrokeWidth (int w) {
    this.boxStrokeWidth = w;
  }

  public void setCheckColor (int red, int green, int blue) {
    this.checkColorRed = red;
    this.checkColorGreen = green;
    this.checkColorBlue = blue;
  }

  public void setCheckColor (int black) {
    this.checkColorRed = black;
    this.checkColorGreen = black;
    this.checkColorBlue = black;
  }

  public void setCheckWidth (int w) {
    this.checkWidth = w;
  }
}


class RadioButton extends CheckButton {
  private int radius;

  private int radioButtonSelected;

  public int buttonStrokeColorRed;
  public int buttonStrokeColorGreen;
  public int buttonStrokeColorBlue;
  private int buttonStrokeWidth;

  public int buttonColorRed;
  public int buttonColorGreen;
  public int buttonColorBlue;

  public int buttonSelectedColorRed;
  public int buttonSelectedColorGreen;
  public int buttonSelectedColorBlue;

  RadioButton (int posX, int posY, String[] values, int radius) {
    super(posX, posY, values);
    this.radius = radius;

    this.radioButtonSelected = 0;

    this.buttonStrokeColorRed = 150;
    this.buttonStrokeColorGreen = 150;
    this.buttonStrokeColorBlue = 150;
    this.buttonStrokeWidth = 1;

    this.buttonColorRed = 200;
    this.buttonColorGreen = 200;
    this.buttonColorBlue = 200;

    this.buttonSelectedColorRed = 0;
    this.buttonSelectedColorGreen = 222;
    this.buttonSelectedColorBlue = 0;
  }

  public void updateChecked() {
    for (int i = 0; i < this.getNbValue(); i++) {
      if (this.isActivated(i) && !this.getButtonClicked()[i]) {
        this.radioButtonSelected = i;
        this.getButtonClicked()[i] = true;
      } else if (this.getButtonClicked()[i] && !this.isActivated(i)) {
        this.getButtonClicked()[i] = false;
      }
    }
  }

  private void displayRadioButton () {
    stroke(this.buttonStrokeColorRed, this.buttonStrokeColorGreen, this.buttonStrokeColorBlue);

    strokeWeight(this.buttonStrokeWidth);
    for (int i = 0; i < this.getNbValue(); i++) {
      if (this.isMouseHoveringButton(i)) {
        fill(this.buttonColorRed - 100, this.buttonColorGreen - 100, this.buttonColorBlue - 100);
      } else {
        fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      }
      circle(this.getX() + this.radius / 2, this.getY() + i * this.getSpaceBetweenLine(), this.radius);
    }
  }

  private void displaySelected () {

    fill(this.buttonSelectedColorRed, this.buttonSelectedColorGreen, this.buttonSelectedColorBlue);
    noStroke();

    circle(this.getX() + this.radius / 2 + 1, this.getY() + radioButtonSelected * this.getSpaceBetweenLine(), this.radius - 4);
  }

  private void displayValue () {
    textAlign(LEFT, CENTER);
    fill(this.valueColorRed, this.valueColorGreen, this.valueColorBlue);
    textSize(this.getValueTextWidth());
    for (int i = 0; i < this.getNbValue(); i++) {
      text(this.getValues()[i], this.getX() + this.radius + 20, this.getY() + i * this.getSpaceBetweenLine() - this.radius / 2);
    }
  }

  public boolean isMouseHoveringButton (int index) {
    return distanceTwoPoints(mouseX, mouseY, this.getX() +this.radius / 2, this.getY() + index * this.getSpaceBetweenLine()) < this.radius / 2;
  }

  public boolean isActivated (int index) {
    return this.isMouseHoveringButton (index) &&  mousePressed;
  }

  public void display() {
    updateChecked();
    displayRadioButton();
    displaySelected();
    displayValue();
  }

  public int getRadius() {
    return this.radius;
  }

  public int getRadioButtonSelected() {
    return this.radioButtonSelected;
  }

  public int getButtonStrokeWidth () {
    return this.buttonStrokeWidth;
  }

  public void setRadius (int radius) {
    this.radius = radius;
  }

  public void setButtonStrokeColor (int red, int green, int blue) {
    this.buttonStrokeColorRed = red;
    this.buttonStrokeColorGreen = green;
    this.buttonStrokeColorBlue = blue;
  }

  public void setButtonStrokeColor (int black) {
    this.buttonStrokeColorRed = black;
    this.buttonStrokeColorGreen = black;
    this.buttonStrokeColorBlue = black;
  }

  public void setButtonStrokeWidth (int w) {
    this.buttonStrokeWidth = w;
  }

  public void setButtonColor (int red, int green, int blue) {
    this.buttonColorRed = red;
    this.buttonColorGreen = green;
    this.buttonColorBlue = blue;
  }

  public void setButtonColor (int black) {
    this.buttonColorRed = black;
    this.buttonColorGreen = black;
    this.buttonColorBlue = black;
  }

  public void setButtonSelectedColor (int red, int green, int blue) {
    this.buttonSelectedColorRed = red;
    this.buttonSelectedColorGreen = green;
    this.buttonSelectedColorBlue = blue;
  }

  public void setButtonSelectedColor (int black) {
    this.buttonSelectedColorRed = black;
    this.buttonSelectedColorGreen = black;
    this.buttonSelectedColorBlue = black;
  }
}
