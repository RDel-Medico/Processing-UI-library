Button b;

void setup () {
  size(600, 600);
  b = new Button (200, 200, 100, 50, "working");
}


void draw () {
  background(220);
  b.display();
}
