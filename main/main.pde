Button b;

void setup () {
  size(600, 600);
  b = new Button (200, 200, 100, 50, "Working");
}


void draw () {
  background(220);
  b.display();
}
