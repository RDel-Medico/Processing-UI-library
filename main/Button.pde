class Button {
  private int x;
  private int y;

  private int width;
  private int height;

  private String text;

  private int fontSize;
  private boolean autoFontSize;
  private int textRed;
  private int textGreen;
  private int textBlue;
  private String font;
  private boolean dirtyFont;

  private int red;
  private int green;
  private int blue;

  private int borderWidth;
  private int borderRed;
  private int borderGreen;
  private int borderBlue;

  private boolean roundedCorners;
  private int cornerRadius;

  private float fontHeight;

  private int hoverRedEffect;
  private int hoverGreenEffect;
  private int hoverBlueEffect;
  private int activatedRedEffect;
  private int activatedGreenEffect;
  private int activatedBlueEffect;

  Button (int x, int y, int w, int h, String text) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.text = text;

    this.autoFontSize = true;
    this.fontSize = 30;
    this.textRed = 20;
    this.textGreen = 200;
    this.textBlue = 180;
    this.font = PFont.list()[0];
    this.dirtyFont = true;

    this.fontHeight = textAscent() - textDescent();

    this.red = 100;
    this.green = 100;
    this.blue = 100;
    this.borderWidth = 5;
    this.borderRed = 0;
    this.borderGreen = 0;
    this.borderBlue = 0;

    this.roundedCorners = true;
    this.cornerRadius = 200;

    this.hoverRedEffect = 50;
    this.hoverGreenEffect = 50;
    this.hoverBlueEffect = 50;

    this.activatedRedEffect = 50;
    this.activatedGreenEffect = 50;
    this.activatedBlueEffect = 50;
  }

  private void displayRect() {
    if (this.isMouseHovering()) {
      fill(red + hoverRedEffect, green + hoverGreenEffect, blue + hoverBlueEffect);
    } else {
      fill(red, green, blue);
    }

    if (this.borderWidth == 0) {
      noStroke();
    } else {
      strokeWeight(this.borderWidth);
      if (this.isActivated()) {
        stroke(borderRed + activatedRedEffect, borderGreen + activatedGreenEffect, borderBlue + activatedBlueEffect);
      } else {
        stroke(borderRed, borderGreen, borderBlue);
      }
    }
    if (this.roundedCorners) {
      rect(x, y, this.width, this.height, this.cornerRadius, this.cornerRadius, this.cornerRadius, this.cornerRadius);
    } else {
      rect(x, y, this.width, this.height);
    }
  }

  private void updateFontHeight() {
    this.fontHeight = textAscent() - textDescent();
  }

  private void setFontSize() {
    float minWidth = 12/this.text.length() * this.width;

    float minHeight = 12/(textDescent() + textAscent()) * this.height;

    this.fontSize = (int)min(minWidth, minHeight) - 2;
  }

  private void displayText() {
    if (this.autoFontSize && this.dirtyFont) {
      this.setFontSize();
      this.dirtyFont = false;
      textFont(createFont(this.font, this.fontSize));
      updateFontHeight();
    } else {
      textFont(createFont(this.font, this.fontSize));
    }

    fill(textRed, textGreen, textBlue);
    textAlign(CENTER);
    text(this.text, this.x +this.width / 2, this.y + this.height / 2 + this.fontHeight / 2);
  }

  void display() {
    this.displayRect();
    this.displayText();
  }

  private void updateCornerRadius() {
    if (this.cornerRadius > height / 2) {
      this.cornerRadius = height / 2;
    }
  }

  boolean isMouseHovering () {
    if (this.roundedCorners) {
      if ((mouseX > this.x && mouseX < this.x + this.width && mouseY > this.y + this.cornerRadius && mouseY < this.y + this.height - this.cornerRadius) ||
        (mouseX > this.x + this.cornerRadius && mouseX < this.x + this.width - this.cornerRadius && mouseY > this.y && mouseY < this.y + this.height)) {
        return true;
      }

      this.updateCornerRadius();

      int distanceTopLeft = distanceTwoPoint(mouseX, mouseY, this.x + this.cornerRadius, this.y + this.cornerRadius);
      int distanceTopRight = distanceTwoPoint(mouseX, mouseY, this.x + this.width - this.cornerRadius, this.y + this.cornerRadius);
      int distanceBottomLeft = distanceTwoPoint(mouseX, mouseY, this.x + this.width - this.cornerRadius, this.y + this.height - this.cornerRadius);
      int distanceBottomRight = distanceTwoPoint(mouseX, mouseY, this.x + this.cornerRadius, this.y + this.height - this.cornerRadius);

      if (distanceTopLeft < this.cornerRadius || distanceTopRight < this.cornerRadius || distanceBottomLeft < this.cornerRadius || distanceBottomRight < this.cornerRadius) {
        return true;
      }
      return false;
    } else {
      return mouseX < this.x + this.width && mouseX > this.x && mouseY < this.y + this.height && mouseY > this.y;
    }
  }

  boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  void setColor(int red, int green, int blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  void setColor(int black) {
    this.red = black;
    this.green = black;
    this.blue = black;
  }

  void setBorderWidth (int bW) {
    this.borderWidth = bW;
  }

  void setBorderColor (int red, int green, int blue) {
    this.borderRed = red;
    this.borderGreen = green;
    this.borderBlue = blue;
  }

  void setBorderColor (int black) {
    this.borderRed = black;
    this.borderGreen = black;
    this.borderBlue = black;
  }

  void setRoundedCorner (int radius) {
    this.roundedCorner = true;
    this.cornerRadius = radius;
  }

  void setSquareCorner () {
    this.roundedCorner = false;
  }

  void setX (int x) {
    this.x = x;
  }

  void setY (int y) {
    this.y = y;
  }

  void setWidth (int w) {
    this.width = w;
  }

  void setHeight (int h) {
    this.height = h;
  }

  void setText(String text) {
    this.text = text;
  }

  void setFontSize (int size) {
    this.fontSize = size;
  }

  void setHoverColorEffect (int red, int green, int blue) {
    this.hoverRedEffect = red;
    this.hoverGreenEffect = green;
    this.hoverBlueEffect = blue;
  }

  void setHoverColorEffect (int black) {
    this.hoverRedEffect = black;
    this.hoverBlueEffect = black;
    this.hoverGreenEffect = black;
  }

  void setActivatedColorEffect (int red, int green, int blue) {
    this.activatedRedEffect = red;
    this.activatedGreenEffect = green;
    this.activatedBlueEffect = blue;
  }

  void setActivatedColorEffect (int black) {
    this.activatedRedEffect = black;
    this.activatedGreenEffect = black;
    this.activatedBlueEffect = black;
  }

  void setTextColor (int red, int green, int blue) {
    this.textRed = red;
    this.textGreen = green;
    this.textBlue = blue;
  }

  void setTextColor (int black) {
    this.textRed = black;
    this.textGreen = black;
    this.textBlue = black;
  }

  void setAutoFontSize (boolean auto) {
    this.autoFontSize = auto;
  }

  void setFont (String font) {
    this.font = font;
  }
}


int distanceTwoPoint(int x1, int y1, int x2, int y2) {
  return (int)sqrt(pow(max(x1, x2) - min(x1, x2), 2) + pow(max(y1, y2) - min(y1, y2), 2));
}
