class Fish {
  int x;
  int y;
  float size;
  int speedX;
  int speedY;

  Fish(int x, int y) {
    this.x = x;
    this.y = y;
    this.size = 0;
    this.speedX = -1; // Speed in the x-direction (leftwards)
    this.speedY = 0;  // Speed in the y-direction (no vertical movement for now)
  }

void display() {
  float scale = size * 2; // Scale factor for proportional growth

  fill(#fbf200);
  rect(x, y, 1 * scale, 1 * scale);
  rect(x, y - 1 * scale, 1 * scale, 1 * scale);
  rect(x, y + 1 * scale, 1 * scale, 1 * scale);
  rect(x, y - 2 * scale, 1 * scale, 1 * scale);

  for (int i = 0; i < 6 * scale; i++) {
    rect(x + 1 * scale, y - 3 * scale + i, 1 * scale, 1 * scale);
  }

  for (int i = 0; i < 8 * scale; i++) {
    rect(x + 2 * scale, y - 4 * scale + i, 1 * scale, 1 * scale);
  }

  rect(x + 3 * scale, y - 4 * scale, 1 * scale, 1 * scale);

  for (int i = 0; i < 4 * scale; i++) {
    rect(x + 3 * scale, y - 2 * scale + i, 1 * scale, 1 * scale);
  }

  rect(x + 3 * scale, y + 3 * scale, 1 * scale, 1 * scale);

  for (int i = 0; i < 3 * scale; i++) {
    rect(x + 4 * scale, y - 1 * scale + i, 1 * scale, 1 * scale);
  }

  rect(x + 5 * scale, y - 2 * scale, 1 * scale, 1 * scale);
  rect(x + 5 * scale, y - 1 * scale, 1 * scale, 1 * scale);
  rect(x + 5 * scale, y + 1 * scale, 1 * scale, 1 * scale);
  rect(x + 5 * scale, y + 2 * scale, 1 * scale, 1 * scale);

  rect(x + 6 * scale, y + 3 * scale, 1 * scale, 1 * scale);
  rect(x + 6 * scale, y - 3 * scale, 1 * scale, 1 * scale);
}

void update() {
  // Update the fish's position based on its speed
  x += -0.25;

  // Wrap around when the fish reaches the left edge
  if (x < 0.5) {
    x = 80;
    y = int(random(10, 20));// Change the y position randomly
  }
}

void grow() {
  // Increase the size of the fish gradually over time
  if (size < 2) {
    size = size + 0.5;
  }
}

void changePixelsToYellow() {

  if (size == 2) {

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        int pixelX = x + i;
        int pixelY = y + j;
        fill(#fbf200);
        rect(pixelX, pixelY, 1, 1);
      }
    }
  }
}
}
