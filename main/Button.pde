

class Button {
  private int x;
  private int y;
  
  private int width;
  private int height;
  
  private int red;
  private int green;
  private int blue;
  
  private int borderWidth;
  private int borderRed;
  private int borderGreen;
  private int borderBlue;
  
  
  Button (int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    
    this.red = 100;
    this.green = 100;
    this.blue = 100;
    this.borderWidth = 0;
    this.borderRed = 0;
    this.borderGreen = 0;
    this.borderBlue = 0;
  }
  
  void display() {
    fill(red, green, blue);
    if (this.borderWidth == 0) {
      noStroke();
    } else {
      strokeWeight(this.borderWidth);
      stroke(borderRed, borderGreen, borderBlue);
    }
    rect(x, y, this.width, this.height);
  }
}
