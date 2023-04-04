public abstract class Toggle {
  int x;
  int y;
  
  boolean value;
  
  void display () {}
}

class ToggleSlider extends Toggle {
  void display() {
    rect(100, 100, 50, 50);
  }
}

class ToggleButton extends Toggle {
  
}
