Button b;

void setup () {
  size(600, 600);
  b = new Button (50, 50, 100, 50, "working");
}


void draw () {
  background(220);
  b.display();
}
