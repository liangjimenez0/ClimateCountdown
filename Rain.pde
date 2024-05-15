class Rain {
  int x = (int) random(75);
  float y = (float) random(-200);

  void fall() {
    noStroke();
    y = y + 0.55;
    fill(#3206C6);
    rect(x, y, 1, 1);
   
    fill(#6B45EA);
    rect(x, y+1, 1, 1);
   
    if (y > 45) {
      x = (int) random(75);
      y = (int) random(0);
    }
  }
}
