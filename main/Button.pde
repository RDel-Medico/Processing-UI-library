

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
  
  private int red;
  private int green;
  private int blue;
  
  private int borderWidth;
  private int borderRed;
  private int borderGreen;
  private int borderBlue;
  
  private boolean roundedCorners;
  
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
    
    this.autoFontSize = false;
    this.fontSize = 30;
    this.textRed = 150;
    this.textGreen = 50;
    this.textBlue = 150;
    this.font = PFont.list()[0];
    
    this.fontHeight = textAscent() - textDescent();
    
    this.red = 100;
    this.green = 100;
    this.blue = 100;
    this.borderWidth = 5;
    this.borderRed = 0;
    this.borderGreen = 0;
    this.borderBlue = 0;
    
    this.roundedCorners = false;
    
    this.hoverRedEffect = 50;
    this.hoverGreenEffect = 50;
    this.hoverBlueEffect = 50;
    
    this.activatedRedEffect = 50;
    this.activatedGreenEffect = 50;
    this.activatedBlueEffect = 50;
  }
  
  void displayRect() {
    if (this.isMouseHovering()) {
      fill(red + hoverRedEffect, green + hoverGreenEffect, blue + hoverBlueEffect);
    } else {
      fill(red, green, blue);
    }
    
    if (this.borderWidth == 0) {
      noStroke();
    } else {
      if (this.isActivated()) {
        strokeWeight(this.borderWidth);
        stroke(borderRed + activatedRedEffect, borderGreen + activatedGreenEffect, borderBlue + activatedBlueEffect);
      } else {
        strokeWeight(this.borderWidth);
        stroke(borderRed, borderGreen, borderBlue);
      }
    }
    rect(x, y, this.width, this.height);
  }
  
  void updateFontHeight() {
    this.fontHeight = textAscent() - textDescent();
  }
  
  void setFontSize() {
  }
  
  void displayText() {
    if (this.autoFontSize) {
      this.setFontSize();
    }
    
    textFont(createFont(this.font, this.fontSize));
    fill(textRed, textGreen, textBlue);
    textAlign(CENTER);
    updateFontHeight();
    text(this.text, this.x +this.width / 2, this.y + this.height / 2 + this.fontHeight / 2);
  }
  
  void display() {
    this.displayRect();
    this.displayText();
  }
  
  boolean isMouseHovering () {
    if (this.roundedCorners) {
      return false;
    } else {
      return mouseX < this.x + this.width && mouseX > this.x && mouseY < this.y + this.height && mouseY > this.y; 
    }
  }
  
  boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }
}
