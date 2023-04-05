public abstract class Toggle {
  int x;
  int y;

  boolean value;

  boolean displayText;


  int textColorRed;
  int textColorGreen;
  int textColorBlue;

  String textOn;
  String textOff;

  boolean valueChanged;

  Toggle (int posX, int posY) {
    this.x = posX;
    this.y = posY;

    this.value = false;

    this.displayText = true;


    this.textColorRed = 0;
    this.textColorGreen = 0;
    this.textColorBlue = 0;

    this.textOn = "ON";
    this.textOff = "OFF";

    this.valueChanged = false;
  }

  void display () {
  }

  abstract boolean isMouseHovering();
  abstract boolean isActivated();

  int getX () {
    return this.x;
  }

  int getY () {
    return this.y;
  }

  boolean getValue () {
    return this.value;
  }

  boolean isTextDisplayed () {
    return this.displayText;
  }

  String getTextOn () {
    return this.textOn;
  }

  String getTextOff () {
    return this.textOff;
  }

  void setX (int x) {
    this.x = x;
  }

  void setY (int y) {
    this.y = y;
  }

  void setDisplayText (boolean displayText) {
    this.displayText = displayText;
  }

  void setTextColor (int red, int green, int blue) {
    this.textColorRed = red;
    this.textColorGreen = green;
    this.textColorBlue = blue;
  }

  void setTextColor (int black) {
    this.textColorRed = black;
    this.textColorGreen = black;
    this.textColorBlue = black;
  }

  void setTextOn (String t) {
    this.textOn = t;
  }

  void setTextOff (String t) {
    this.textOff = t;
  }
}


class ToggleSlider extends Toggle {

  int width;
  int height;

  int backgroundColorRed;
  int backgroundColorGreen;
  int backgroundColorBlue;
  int backgroundStrokeColorRed;
  int backgroundStrokeColorGreen;
  int backgroundStrokeColorBlue;
  int backgroundStrokeWidth;

  int indicatorColorRed;
  int indicatorColorGreen;
  int indicatorColorBlue;
  int indicatorStrokeColorRed;
  int indicatorStrokeColorGreen;
  int indicatorStrokeColorBlue;
  int indicatorStrokeWidth;////////////////

  float animationDuration;
  int animationCurrentFrame;
  int animationDurationInFrame;
  boolean animation;
  float avancementInAnimation;
  boolean animated;

  int textSize;

  boolean centered;

  ToggleSlider (int posX, int posY, int w, int h) {
    super(posX, posY);
    this.width = w;
    this.height = h;

    this.centered = true;

    this.backgroundColorRed = 2;
    this.backgroundColorGreen = 210;
    this.backgroundColorBlue = 86;
    this.backgroundStrokeColorRed = 0;
    this.backgroundStrokeColorGreen = 180;
    this.backgroundStrokeColorBlue = 56;
    this.backgroundStrokeWidth = 2;

    this.indicatorColorRed = 255;
    this.indicatorColorGreen = 255;
    this.indicatorColorBlue = 255;
    this.indicatorStrokeColorRed = 210;
    this.indicatorStrokeColorGreen = 210;
    this.indicatorStrokeColorBlue = 210;
    this.indicatorStrokeWidth = 2;


    this.animationDuration = 0.5;
    this.animationDurationInFrame = (int)(this.animationDuration * 60);
    this.animation = false;
    this.animationCurrentFrame = 0;
    this.avancementInAnimation = 0;

    this.animated = true;

    this.textSize = 20;
  }

  void displayBar() {
    stroke(this.backgroundStrokeColorRed, this.backgroundStrokeColorGreen, this.backgroundStrokeColorBlue);
    strokeWeight(this.backgroundStrokeWidth);
    fill(this.backgroundColorRed, this.backgroundColorGreen, this.backgroundColorBlue);

    if (this.centered) {
      rect(this.x - this.width / 2, this.y - this.height / 2, this.width, this.height, this.height / 2, this.height / 2, this.height / 2, this.height / 2);
    } else {
      rect(this.x, this.y, this.width, this.height, this.height / 2, this.height / 2, this.height / 2, this.height / 2);
    }
  }

  void displayIndicator() {
    stroke(this.indicatorStrokeColorRed, this.indicatorStrokeColorGreen, this.indicatorStrokeColorBlue);
    strokeWeight(this.indicatorStrokeWidth);
    fill(this.indicatorColorRed, this.indicatorColorGreen, this.indicatorColorBlue);

    if (this.value) {
      if (this.centered) {
        circle(this.x + this.width / 2 - this.width / 4, this.y, min(this.height, this.width) - 5);
      } else {
        circle(this.x + this.width - this.width / 4, this.y + this.height / 2, min(this.height, this.width) - 5);
      }
    } else {
      if (this.centered) {
        circle(this.x - this.width / 4, this.y, min(this.height, this.width) - 5);
      } else {
        circle(this.x + this.width / 4, this.y + this.height / 2, min(this.height, this.width) - 5);
      }
    }
  }

  void displayText() {
    textAlign(CENTER, CENTER);
    textSize(this.textSize);
    fill(this.textColorRed, this.textColorGreen, this.textColorBlue);

    if (this.value) {
      if (this.centered) {
        text(this.textOn, this.x - this.width / 4, this. y);
      } else {
        text(this.textOn, this.x + this.width / 4, this. y + this.height / 2);
      }
    } else {
      if (this.centered) {
        text(this.textOff, this.x + this.width / 4, this. y);
      } else {
        text(this.textOff, this.x + this.width - this.width / 4, this. y + this.height / 2);
      }
    }
  }

  void animation() {
    if (this.animationCurrentFrame == this.animationDurationInFrame) {
      this.value = !this.value;
      this.valueChanged = true;
      this.animation = false;
      this.animationCurrentFrame = 0;
    } else {

      textAlign(CENTER, CENTER);
      textSize(this.textSize);
      fill(this.textColorRed, this.textColorGreen, this.textColorBlue);

      if (this.centered) {
        text(this.textOn, this.x - this.width / 4, this. y);
        text(this.textOff, this.x + this.width / 4, this. y);
      } else {
        text(this.textOn, this.x + this.width / 4, this. y + this.height / 2);
        text(this.textOff, this.x + this.width - this.width / 4, this. y + this.height / 2);
      }

      stroke(this.indicatorStrokeColorRed, this.indicatorStrokeColorGreen, this.indicatorStrokeColorBlue);
      strokeWeight(this.indicatorStrokeWidth);
      fill(this.indicatorColorRed, this.indicatorColorGreen, this.indicatorColorBlue);

      if (this.value) {
        if (this.centered) {
          circle(this.x + this.width / 2 - this.width / 4 - ((this.width / 2) * this.avancementInAnimation), this.y, min(this.height, this.width) - 5);
        } else {
          circle(this.x + this.width - this.width / 4 - ((this.width / 2) * this.avancementInAnimation), this.y + this.height / 2, min(this.height, this.width) - 5);
        }
      } else {
        if (this.centered) {
          circle(this.x - this.width / 4 + ((this.width / 2) * this.avancementInAnimation), this.y, min(this.height, this.width) - 5);
        } else {
          circle(this.x + this.width / 4 + ((this.width / 2) * this.avancementInAnimation), this.y + this.height / 2, min(this.height, this.width) - 5);
        }
      }

      this.animationCurrentFrame++;
      this.avancementInAnimation = ((this.animationCurrentFrame * 100) / this.animationDurationInFrame );
      this.avancementInAnimation = this.avancementInAnimation / 100;
    }
  }

  void updateValue() {
    if (!this.animation) {
      if (this.isActivated() && !this.valueChanged && this.animated) {
        this.animation = true;
      } else if (this.isActivated() && !this.valueChanged && !this.animated) {
        this.value = !this.value;
        this.valueChanged = true;
      } else if (this.valueChanged && !this.isActivated()) {
        this.valueChanged = false;
      }
    }
  }

  void display() {
    updateValue();
    displayBar();
    if (this.animation) {
      this.animation();
    } else {
      displayIndicator();
      displayText();
    }
  }

  boolean isMouseHovering() {
    if (this.centered) {
      if (mouseX < this.x + this.width / 2 - this.height / 2 && mouseX > this.x - this.width / 2 + this.height / 2 && mouseY > this.y - this.height / 2 && mouseY < this.y + this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.x - this.width / 2 + this.height / 2, this.y) <= this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.x + this.width / 2 - this.height / 2, this.y) <= this.height / 2) {
        return true;
      }
    } else {
      if (mouseX < this.x + this.width - this.height / 2 && mouseX > this.x + this.height / 2 && mouseY > this.y && mouseY < this.y + this.height
        || distanceTwoPoints(mouseX, mouseY, this.x + this.height / 2, this.y + this.height / 2) <= this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.x + this.width - this.height / 2, this.y + this.height / 2) <= this.height / 2) {
        return true;
      }
    }
    return false;
  }

  boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  int getWidth () {
    return this.width;
  }

  int getHeight () {
    return this.height;
  }

  int getBackgroundStrokeWidth () {
    return this.backgroundStrokeWidth;
  }

  int getIndicatorStrokeWidth () {
    return this.indicatorStrokeWidth;
  }

  float getAnimationDuration () {
    return this.animationDuration;
  }

  int getAnimationCurrentFrame () {
    return this.animationCurrentFrame;
  }

  int getAnimationDurationInFrame () {
    return this.animationDurationInFrame;
  }

  boolean isAnimated () {
    return this.animated;
  }

  boolean isAnimationCurrentlyActive () {
    return this.animation;
  }

  boolean isToggleCentered () {
    return this.centered;
  }

  int getTextSize () {
    return this.textSize;
  }

  void setWidth (int w) {
    this.width = w;
  }

  void setHeight (int h) {
    this.height = h;
  }

  void setBackgroundColor (int red, int green, int blue) {
    this.backgroundColorRed = red;
    this.backgroundColorGreen = green;
    this.backgroundColorBlue = blue;
  }

  void setBackgroundColor (int black) {
    this.backgroundColorRed = black;
    this.backgroundColorGreen = black;
    this.backgroundColorBlue = black;
  }

  void setBackgroundStrokeColor (int red, int green, int blue) {
    this.backgroundStrokeColorRed = red;
    this.backgroundStrokeColorGreen = green;
    this.backgroundStrokeColorBlue = blue;
  }

  void setBackgroundStrokeColor (int black) {
    this.backgroundStrokeColorRed = black;
    this.backgroundStrokeColorGreen = black;
    this.backgroundStrokeColorBlue = black;
  }

  void setIndicatorColor (int red, int green, int blue) {
    this.indicatorColorRed = red;
    this.indicatorColorGreen = green;
    this.indicatorColorBlue = blue;
  }

  void setIndicatorColor (int black) {
    this.indicatorColorRed = black;
    this.indicatorColorGreen = black;
    this.indicatorColorBlue = black;
  }

  void setIndicatorStrokeColor (int red, int green, int blue) {
    this.indicatorStrokeColorRed = red;
    this.indicatorStrokeColorGreen = green;
    this.indicatorStrokeColorBlue = blue;
  }

  void setIndicatorStrokeColor (int black) {
    this.indicatorStrokeColorRed = black;
    this.indicatorStrokeColorGreen = black;
    this.indicatorStrokeColorBlue = black;
  }

  void setAnimationDuration (float duration) {
    this.animationDuration = duration;
    this.animationDurationInFrame = (int)(duration * 60);
  }

  void setAnimated (boolean animated) {
    this.animated = animated;
  }

  void setCentered (boolean centered) {
    this.centered = centered;
  }

  void setTextSize (int textSize) {
    this.textSize = textSize;
  }
}


class ToggleButton extends Toggle {

  int radius;

  int buttonColorRed;
  int buttonColorGreen;
  int buttonColorBlue;

  int textSize;

  ToggleButton (int posX, int posY, int radius) {
    super(posX, posY);
    this.radius = radius;

    this.buttonColorRed = 222;
    this.buttonColorGreen = 0;
    this.buttonColorBlue = 0;

    this.textSize = 30;
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
    fill(this.buttonColorRed - 75, this.buttonColorGreen - 75, this.buttonColorBlue - 75);
    if (this.value) {
      circle(this.x, this.y, this.radius);
      rect(this.x - this.radius / 2, this.y, this.radius, - (this.radius / 16));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.x, this.y - this.radius / 16, this.radius);
    } else {
      circle(this.x, this.y, this.radius);
      rect(this.x - this.radius / 2, this.y, this.radius, - (this.radius / 2));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.x, this.y - this.radius / 2, this.radius);
    }
  }

  boolean isMouseHovering() {
    if (this.value) {
      if (mouseX > this.x - this.radius / 2 && mouseX < this.x + this.radius / 2 && mouseY < this.y + this.radius /16 && mouseY > this.y
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y) <= this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y - this.radius / 16) <= this.radius / 2) {
        return true;
      }
    } else {
      if (mouseX > this.x - this.radius / 2 && mouseX < this.x + this.radius / 2 && mouseY < this.y + this.radius /2 && mouseY > this.y
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y) <= this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.x, this.y - this.radius / 2) <= this.radius / 2) {
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

  int getRadius () {
    return this.radius;
  }

  int getTextSize () {
    return this.textSize;
  }

  void setRadius (int r) {
    this.radius = r;
  }

  void setButtonColor (int red, int green, int blue) {
    this.buttonColorRed = red;
    this.buttonColorGreen = green;
    this.buttonColorBlue = blue;
  }

  void setButtonColor (int black) {
    this.buttonColorRed = black;
    this.buttonColorGreen = black;
    this.buttonColorBlue = black;
  }

  void setTextSize (int textSize) {
    this.textSize = textSize;
  }
}
