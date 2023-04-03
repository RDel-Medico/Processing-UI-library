Cursor c;

void setup () {
  size(600, 600);
  c = new Cursor (200, 200, 200, 20, 0, 1000);
}


void draw () {
  background(220);
  c.display();
  
  println(c.selectorDragged);
}
