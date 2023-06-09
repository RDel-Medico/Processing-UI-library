Button b1;
Button b2;
Cursor c;
Toggle t1;
Toggle t2;
CheckButton cb1;
CheckButton cb2;
SearchBar s;

void setup () {
  size(600, 600);
  b1 = new Button(250, 50, 200, 30, "EXAMPLE");
  b1.setSquareCorner();
  b2 = new Button(250, 100, 200, 30, "EXAMPLE");
  c = new Cursor(250, 150, 200, 15, 50, 2000, "EXAMPLE");
  t1 = new ToggleButton(250, 250, 50);
  t2 = new ToggleSlider(250, 350, 60, 30);
  cb1 = new CheckBox(150, 450, new String[] {"aa", "vb", "TTTTTTTTTT"}, 10, 10);
  cb2 = new RadioButton(350, 450, new String[] {"aa", "vb", "bb"}, 20);
  s = new SearchBar(300, 550, 200, 30);
}


void draw () {
  background(220);
  b1.display();
  b2.display();
  c.display();
  t1.display();
  t2.display();
  cb1.display();
  cb2.display();
  s.display();
}
