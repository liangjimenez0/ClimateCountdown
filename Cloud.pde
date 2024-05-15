class Cloud {

  int x;
  int y;
  int c;

  Cloud (int myx, int myy) {
    c= int (random(100, 255));
    x = myx;
    y = myy;
  }

  void display() {
    colorMode(RGB);
    fill(255, 255, 255);
    rect(x, y+2, 1, 3);//left rect
    rect(x+1, y, 3, 6);//middle rect
    rect(x + 3, y+1, 2, 4 ); //right rect
  }
}
