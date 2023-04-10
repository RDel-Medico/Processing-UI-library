public abstract class Toggle {
  private int x;
  private int y;

  private boolean value;

  private boolean displayText;

  private String textOn;
  private String textOff;

  private boolean valueChanged;

  Toggle (int posX, int posY) {
    this.x = posX;
    this.y = posY;

    this.value = false;

    this.displayText = true;

    this.textOn = "ON";
    this.textOff = "OFF";

    this.valueChanged = false;
  }

  public abstract void display ();

  public abstract boolean isMouseHovering();
  public abstract boolean isActivated();

  public int getX () {
    return this.x;
  }

  public int getY () {
    return this.y;
  }

  public boolean getValue () {
    return this.value;
  }
  
  public boolean getValueChanged () {
    return this.valueChanged; 
  }

  public boolean isTextDisplayed () {
    return this.displayText;
  }

  public String getTextOn () {
    return this.textOn;
  }

  public String getTextOff () {
    return this.textOff;
  }

  public void setX (int x) {
    this.x = x;
  }

  public void setY (int y) {
    this.y = y;
  }

  public void setDisplayText (boolean displayText) {
    this.displayText = displayText;
  }

  public void setTextOn (String t) {
    this.textOn = t;
  }

  public void setTextOff (String t) {
    this.textOff = t;
  }
  
  public void setValue (boolean value) {
    this.value = value; 
  }
  
  public void setValueChanged (boolean v) {
    this.valueChanged = v;
  }
}


class ToggleSlider extends Toggle {

  private int width;
  private int height;

  private int backgroundColorRed;
  private int backgroundColorGreen;
  private int backgroundColorBlue;
  private int backgroundStrokeColorRed;
  private int backgroundStrokeColorGreen;
  private int backgroundStrokeColorBlue;
  private int backgroundStrokeWidth;

  private int indicatorColorRed;
  private int indicatorColorGreen;
  private int indicatorColorBlue;
  private int indicatorStrokeColorRed;
  private int indicatorStrokeColorGreen;
  private int indicatorStrokeColorBlue;
  private int indicatorStrokeWidth;
  
  private int textColorRed;
  private int textColorGreen;
  private int textColorBlue;

  private float animationDuration;
  private int animationCurrentFrame;
  private int animationDurationInFrame;
  private boolean animation;
  private float avancementInAnimation;
  private boolean animated;

  private int textSize;

  private boolean centered;

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
    
    this.textColorRed = 0;
    this.textColorGreen = 0;
    this.textColorBlue = 0;

    this.animationDuration = 0.5;
    this.animationDurationInFrame = (int)(this.animationDuration * 60);
    this.animation = false;
    this.animationCurrentFrame = 0;
    this.avancementInAnimation = 0;

    this.animated = true;

    this.textSize = 20;
  }

  private void displayBar() {
    stroke(this.backgroundStrokeColorRed, this.backgroundStrokeColorGreen, this.backgroundStrokeColorBlue);
    strokeWeight(this.backgroundStrokeWidth);
    fill(this.backgroundColorRed, this.backgroundColorGreen, this.backgroundColorBlue);

    if (this.centered) {
      rect(this.getX() - this.width / 2, this.getY() - this.height / 2, this.width, this.height, this.height / 2, this.height / 2, this.height / 2, this.height / 2);
    } else {
      rect(this.getX(), this.getY(), this.width, this.height, this.height / 2, this.height / 2, this.height / 2, this.height / 2);
    }
  }

  private void displayIndicator() {
    stroke(this.indicatorStrokeColorRed, this.indicatorStrokeColorGreen, this.indicatorStrokeColorBlue);
    strokeWeight(this.indicatorStrokeWidth);
    fill(this.indicatorColorRed, this.indicatorColorGreen, this.indicatorColorBlue);

    if (this.getValue()) {
      if (this.centered) {
        circle(this.getX() + this.width / 2 - this.width / 4, this.getY(), min(this.height, this.width) - 5);
      } else {
        circle(this.getX() + this.width - this.width / 4, this.getY() + this.height / 2, min(this.height, this.width) - 5);
      }
    } else {
      if (this.centered) {
        circle(this.getX() - this.width / 4, this.getY(), min(this.height, this.width) - 5);
      } else {
        circle(this.getX() + this.width / 4, this.getY() + this.height / 2, min(this.height, this.width) - 5);
      }
    }
  }

  private void displayText() {
    textAlign(CENTER, CENTER);
    textSize(this.textSize);
    fill(this.textColorRed, this.textColorGreen, this.textColorBlue);

    if (this.getValue()) {
      if (this.centered) {
        text(this.getTextOn(), this.getX() - this.width / 4, this.getY());
      } else {
        text(this.getTextOn(), this.getX() + this.width / 4, this.getY() + this.height / 2);
      }
    } else {
      if (this.centered) {
        text(this.getTextOff(), this.getX() + this.width / 4, this.getY());
      } else {
        text(this.getTextOff(), this.getX() + this.width - this.width / 4, this.getY() + this.height / 2);
      }
    }
  }

  private void animation() {
    if (this.animationCurrentFrame == this.animationDurationInFrame) {
      this.setValue(!this.getValue());
      this.setValueChanged(true);
      this.animation = false;
      this.animationCurrentFrame = 0;
    } else {

      textAlign(CENTER, CENTER);
      textSize(this.textSize);
      fill(this.textColorRed, this.textColorGreen, this.textColorBlue);

      if (this.centered) {
        text(this.getTextOn(), this.getX() - this.width / 4, this.getY());
        text(this.getTextOff(), this.getX() + this.width / 4, this.getY());
      } else {
        text(this.getTextOn(), this.getX() + this.width / 4, this.getY() + this.height / 2);
        text(this.getTextOff(), this.getX() + this.width - this.width / 4, this.getY() + this.height / 2);
      }

      stroke(this.indicatorStrokeColorRed, this.indicatorStrokeColorGreen, this.indicatorStrokeColorBlue);
      strokeWeight(this.indicatorStrokeWidth);
      fill(this.indicatorColorRed, this.indicatorColorGreen, this.indicatorColorBlue);

      if (this.getValue()) {
        if (this.centered) {
          circle(this.getX() + this.width / 2 - this.width / 4 - ((this.width / 2) * this.avancementInAnimation), this.getY(), min(this.height, this.width) - 5);
        } else {
          circle(this.getX() + this.width - this.width / 4 - ((this.width / 2) * this.avancementInAnimation), this.getY() + this.height / 2, min(this.height, this.width) - 5);
        }
      } else {
        if (this.centered) {
          circle(this.getX() - this.width / 4 + ((this.width / 2) * this.avancementInAnimation), this.getY(), min(this.height, this.width) - 5);
        } else {
          circle(this.getX() + this.width / 4 + ((this.width / 2) * this.avancementInAnimation), this.getY() + this.height / 2, min(this.height, this.width) - 5);
        }
      }

      this.animationCurrentFrame++;
      this.avancementInAnimation = ((this.animationCurrentFrame * 100) / this.animationDurationInFrame );
      this.avancementInAnimation = this.avancementInAnimation / 100;
    }
  }

  public void updateValue() {
    if (!this.animation) {
      if (this.isActivated() && !this.getValueChanged() && this.animated) {
        this.animation = true;
      } else if (this.isActivated() && !this.getValueChanged() && !this.animated) {
        this.setValue(!this.getValue());
        this.setValueChanged(true);
      } else if (this.getValueChanged() && !this.isActivated()) {
        this.setValueChanged(false);
      }
    }
  }

  public void display() {
    updateValue();
    displayBar();
    if (this.animation) {
      this.animation();
    } else {
      displayIndicator();
      displayText();
    }
  }

  public boolean isMouseHovering() {
    if (this.centered) {
      if (mouseX < this.getX() + this.width / 2 - this.height / 2 && mouseX > this.getX() - this.width / 2 + this.height / 2 && mouseY > this.getY() - this.height / 2 && mouseY < this.getY() + this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.getX() - this.width / 2 + this.height / 2, this.getY()) <= this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.getX() + this.width / 2 - this.height / 2, this.getY()) <= this.height / 2) {
        return true;
      }
    } else {
      if (mouseX < this.getX() + this.width - this.height / 2 && mouseX > this.getX() + this.height / 2 && mouseY > this.getY() && mouseY < this.getY() + this.height
        || distanceTwoPoints(mouseX, mouseY, this.getX() + this.height / 2, this.getY() + this.height / 2) <= this.height / 2
        || distanceTwoPoints(mouseX, mouseY, this.getX() + this.width - this.height / 2, this.getY() + this.height / 2) <= this.height / 2) {
        return true;
      }
    }
    return false;
  }

  public boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  public int getWidth () {
    return this.width;
  }

  public int getHeight () {
    return this.height;
  }

  public int getBackgroundStrokeWidth () {
    return this.backgroundStrokeWidth;
  }

  public int getIndicatorStrokeWidth () {
    return this.indicatorStrokeWidth;
  }

  public float getAnimationDuration () {
    return this.animationDuration;
  }

  public int getAnimationCurrentFrame () {
    return this.animationCurrentFrame;
  }

  public int getAnimationDurationInFrame () {
    return this.animationDurationInFrame;
  }

  public boolean isAnimated () {
    return this.animated;
  }

  public boolean isAnimationCurrentlyActive () {
    return this.animation;
  }

  public boolean isToggleCentered () {
    return this.centered;
  }

  public int getTextSize () {
    return this.textSize;
  }
  
  public void setTextColor (int red, int green, int blue) {
    this.textColorRed = red;
    this.textColorGreen = green;
    this.textColorBlue = blue;
  }

  public void setTextColor (int black) {
    this.textColorRed = black;
    this.textColorGreen = black;
    this.textColorBlue = black;
  }

  public void setWidth (int w) {
    this.width = w;
  }

  public void setHeight (int h) {
    this.height = h;
  }

  public void setBackgroundColor (int red, int green, int blue) {
    this.backgroundColorRed = red;
    this.backgroundColorGreen = green;
    this.backgroundColorBlue = blue;
  }

  public void setBackgroundColor (int black) {
    this.backgroundColorRed = black;
    this.backgroundColorGreen = black;
    this.backgroundColorBlue = black;
  }

  public void setBackgroundStrokeColor (int red, int green, int blue) {
    this.backgroundStrokeColorRed = red;
    this.backgroundStrokeColorGreen = green;
    this.backgroundStrokeColorBlue = blue;
  }

  public void setBackgroundStrokeColor (int black) {
    this.backgroundStrokeColorRed = black;
    this.backgroundStrokeColorGreen = black;
    this.backgroundStrokeColorBlue = black;
  }

  public void setIndicatorColor (int red, int green, int blue) {
    this.indicatorColorRed = red;
    this.indicatorColorGreen = green;
    this.indicatorColorBlue = blue;
  }

  public void setIndicatorColor (int black) {
    this.indicatorColorRed = black;
    this.indicatorColorGreen = black;
    this.indicatorColorBlue = black;
  }

  public void setIndicatorStrokeColor (int red, int green, int blue) {
    this.indicatorStrokeColorRed = red;
    this.indicatorStrokeColorGreen = green;
    this.indicatorStrokeColorBlue = blue;
  }

  public void setIndicatorStrokeColor (int black) {
    this.indicatorStrokeColorRed = black;
    this.indicatorStrokeColorGreen = black;
    this.indicatorStrokeColorBlue = black;
  }

  public void setAnimationDuration (float duration) {
    this.animationDuration = duration;
    this.animationDurationInFrame = (int)(duration * 60);
  }

  public void setAnimated (boolean animated) {
    this.animated = animated;
  }

  public void setCentered (boolean centered) {
    this.centered = centered;
  }

  public void setTextSize (int textSize) {
    this.textSize = textSize;
  }
}


class ToggleButton extends Toggle {

  private int radius;

  private int buttonColorRed;
  private int buttonColorGreen;
  private int buttonColorBlue;
  
  private int textColorRed;
  private int textColorGreen;
  private int textColorBlue;

  private int textSize;

  ToggleButton (int posX, int posY, int radius) {
    super(posX, posY);
    this.radius = radius;

    this.buttonColorRed = 222;
    this.buttonColorGreen = 0;
    this.buttonColorBlue = 0;
    
    this.textColorRed = 0;
    this.textColorGreen = 0;
    this.textColorBlue = 0;

    this.textSize = 30;
  }

  private void displayText() {
    textSize(this.textSize);
    textAlign(CENTER);
    fill(this.textColorRed, this.textColorGreen, this.textColorBlue);
    if (this.getValue()) {
      text(this.getTextOn(), this.getX(), this.getY() + this.radius / 2 + 30);
    } else {
      text(this.getTextOff(), this.getY(), this.getY() + this.radius / 2 + 30);
    }
  }

  private void displayButton() {
    noStroke();
    fill(this.buttonColorRed - 75, this.buttonColorGreen - 75, this.buttonColorBlue - 75);
    if (this.getValue()) {
      circle(this.getX(), this.getY(), this.radius);
      rect(this.getX() - this.radius / 2, this.getY(), this.radius, - (this.radius / 16));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.getX(), this.getY() - this.radius / 16, this.radius);
    } else {
      circle(this.getX(), this.getY(), this.radius);
      rect(this.getX() - this.radius / 2, this.getY(), this.radius, - (this.radius / 2));

      fill(this.buttonColorRed, this.buttonColorGreen, this.buttonColorBlue);
      circle(this.getX(), this.getY() - this.radius / 2, this.radius);
    }
  }

  public boolean isMouseHovering() {
    if (this.getValue()) {
      if (mouseX > this.getX() - this.radius / 2 && mouseX < this.getX() + this.radius / 2 && mouseY < this.getY() + this.radius /16 && mouseY > this.getY()
        || distanceTwoPoints(mouseX, mouseY, this.getX(), this.getY()) <= this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.getX(), this.getY() - this.radius / 16) <= this.radius / 2) {
        return true;
      }
    } else {
      if (mouseX > this.getX() - this.radius / 2 && mouseX < this.getX() + this.radius / 2 && mouseY < this.getY() + this.radius /2 && mouseY > this.getY()
        || distanceTwoPoints(mouseX, mouseY, this.getX(), this.getY()) <= this.radius / 2
        || distanceTwoPoints(mouseX, mouseY, this.getX(), this.getY() - this.radius / 2) <= this.radius / 2) {
        return true;
      }
    }

    return false;
  }

  public boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  public void updateValue() {
    if (this.isActivated() && !this.getValueChanged()) {
      this.setValue(!this.getValue());
      this.setValueChanged(true);
    } else if (this.getValueChanged() && !this.isActivated()) {
      this.setValueChanged(false);
    }
  }

  public void display() {
    updateValue();
    if (this.isTextDisplayed()) {
      displayText();
    }
    displayButton();
  }

  public int getRadius () {
    return this.radius;
  }

  public int getTextSize () {
    return this.textSize;
  }
  
  public void setTextColor (int red, int green, int blue) {
    this.textColorRed = red;
    this.textColorGreen = green;
    this.textColorBlue = blue;
  }

  public void setTextColor (int black) {
    this.textColorRed = black;
    this.textColorGreen = black;
    this.textColorBlue = black;
  }

  public void setRadius (int r) {
    this.radius = r;
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

  public void setTextSize (int textSize) {
    this.textSize = textSize;
  }
}
