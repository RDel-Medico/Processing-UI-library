class SearchBar {
  int x;
  int y;
  int width;
  int height;
  String value;

  boolean centered;

  boolean isSelected;

  int backgroundColorRed;
  int backgroundColorGreen;
  int backgroundColorBlue;

  int backgroundHoveredColorRed;
  int backgroundHoverColorGreen;
  int backgroundHoverColorBlue;

  int strokeColorRed;
  int strokeColorGreen;
  int strokeColorBlue;

  int strokeHoverColorRed;
  int strokeHoverColorGreen;
  int strokeHoverColorBlue;
  
  int strokeWeight;

  SearchBar (int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;

    this.centered = true;

    this.isSelected = false;

    this.backgroundColorRed = 255;
    this.backgroundColorGreen = 255;
    this.backgroundColorBlue = 255;

    this.backgroundHoveredColorRed = 200;
    this.backgroundHoverColorGreen = 200;
    this.backgroundHoverColorBlue = 200;

    this.strokeColorRed = 0;
    this.strokeColorGreen = 0;
    this.strokeColorBlue = 0;

    this.strokeHoverColorRed = 50;
    this.strokeHoverColorGreen = 50;
    this.strokeHoverColorBlue = 50;
    
    this.strokeWeight = 2;
  }



  void displayRect () {
    strokeWeight(this.strokeWeight);
    if (isMouseHovering()) {
      stroke(strokeHoverColorRed, strokeHoverColorGreen, strokeHoverColorBlue);
      fill(backgroundHoveredColorRed, backgroundHoverColorGreen, backgroundHoverColorBlue);
    } else {
      stroke(strokeColorRed, strokeColorGreen, strokeColorBlue);
      fill(backgroundColorRed, backgroundColorGreen, backgroundColorBlue);
    }

    if (this.centered) {
      rect(this.x - this.width / 2, this.y - this.height / 2, this.width, this.height);
    } else {
      rect(this.x, this.y, this.width, this.height);
    }
  }

  void display () {
    displayRect();
  }

  boolean isMouseHovering() {
    if (this.centered) {
      return mouseX > this.x - this.width / 2 && mouseX < this.x + this.width / 2 && mouseY > this.y - this.height / 2 && mouseY < this.y + this.height / 2;
    } else {
      return mouseX > this.x && mouseX < this.x + this.width && mouseY > this.y && mouseY < this.y + this.height;
    }
  }

  boolean isClicked () {
    return  mousePressed && isMouseHovering();
  }
}
