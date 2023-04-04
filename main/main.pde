Button b1;
Button b2;
Cursor c;
Toggle t1;
Toggle t2;

void setup () {
  size(600, 600);
  b1 = new Button(150, 50, 200, 30, "EXAMPLE");
  b1.setSquareCorner();
  b2 = new Button(150, 100, 200, 30, "EXAMPLE");
  c = new Cursor(150, 150, 200, 15, 50, 2000, "EXAMPLE");
  t1 = new ToggleButton(150, 250, 50);
  t2 = new ToggleSlider(150, 350, 60, 30);
}


void draw () {
  background(220);
  b1.display();
  b2.display();
  c.display();
  t1.display();
  t2.display();
}
