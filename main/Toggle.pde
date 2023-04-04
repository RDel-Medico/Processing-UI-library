public abstract class Toggle {
  int x;
  int y;

  boolean value;

  boolean displayText;

  int textSize;
  int textColorRed;
  int textColorGreen;
  int textColorBlue;

  boolean valueChanged;

  Toggle (int posX, int posY) {
    this.x = posX;
    this.y = posY;

    this.value = false;

    this.displayText = true;

    this.textSize = 30;
    this.textColorRed = 0;
    this.textColorGreen = 0;
    this.textColorBlue = 0;

    this.valueChanged = false;
  }

  void display () {
  }

  abstract boolean isMouseHovering();
  abstract boolean isActivated();
}

class ToggleSlider extends Toggle {

  int width;
  int height;

  ToggleSlider (int posX, int posY, int w, int h) {
    super(posX, posY);
    this.width = w;
    this.height = h;
  }

  void display() {
    rect(this.x, this.y, this.width, this.height);
  }

  boolean isMouseHovering() {
    return true;
  }

  boolean isActivated() {
    return false;
  }
}

class ToggleButton extends Toggle {

  int radius;

  String textOn;
  String textOff;

  int buttonColorRed;
  int buttonColorGreen;
  int buttonColorBlue;

  ToggleButton (int posX, int posY, int radius) {
    super(posX, posY);
    this.radius = radius;

    this.textOn = "ON";
    this.textOff = "OFF";

    this.buttonColorRed = 222;
    this.buttonColorGreen = 0;
    this.buttonColorBlue = 0;
  }

  void displayText() {
    textSize(this.textSize);
    textAlign(CENTER);
    fill(this.textColorRed, this.textColorGreen, this.textColorBlue);
    if (this.value) {
      text(this.textOn, this.x, this.y + this.radius / 2 + 30);
    } else {
      text(this.textOff, this.x, this.y + this.radius / 2 + 30);
    }
  }

  void displayButton() {
    noStroke();
    if (this.value) {
      fill(this.buttonColorRed - 75, this.buttonColorGreen - 75, this.buttonColorBlue - 75);

      circle(this.x, this.y, this.radius);
      rect(this.x - this.radius / 2, this.y, this.radius, - (this.radius / 16));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.x, this.y - this.radius / 16, this.radius);
    } else {
      fill(this.buttonColorRed - 75, this.buttonColorGreen - 75, this.buttonColorBlue - 75);

      circle(this.x, this.y, this.radius);
      rect(this.x - this.radius / 2, this.y, this.radius, - (this.radius / 2));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.x, this.y - this.radius / 2, this.radius);
    }
  }

  boolean isMouseHovering() {
    if (this.value) {
      if (mouseX > this.x - this.radius / 2 && mouseX < this.x + this.radius / 2 && mouseY < this.y + this.radius /16 && mouseY > this.y
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y) < this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y - this.radius / 16) < this.radius / 2) {
        return true;
      }
    } else {
      if (mouseX > this.x - this.radius / 2 && mouseX < this.x + this.radius / 2 && mouseY < this.y + this.radius /2 && mouseY > this.y
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y) < this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y - this.radius / 2) < this.radius / 2) {
        return true;
      }
    }

    return false;
  }

  boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  void updateValue() {
    if (this.isActivated() && !this.valueChanged) {
      this.value = !this.value;
      this.valueChanged = true;
    } else if (this.valueChanged && !this.isActivated()) {
      this.valueChanged = false;
    }
  }

  void display() {
    updateValue();
    if (this.displayText) {
      displayText();
    }
    displayButton();
  }
}
