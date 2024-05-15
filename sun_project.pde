import processing.sound.*;

SoundFile soundfile;

AEC aec;
float animationProgress = 0;
float pulsingValue = 0;
color red = #FF0112;
color yellow = #fbf200;
color yellow2 = #FCCD06;
color yellow3 = #FCA80C;
color yellow4 = #FD6D15;
color yellow5 = #FE401C;
int beginningTime=0;
int currentTime;

float randomColVal[][] = new float[100][100];

float randomDarkness[][] = new float[100][100];

Rain[] drops = new Rain[90];
float waterLevel = 0;
int startTime = 0;
boolean waterFilling = false;
int rectHeight = 0;
int frameCounter = 0; // Counter for tracking frame rates
int frameInterval = 8; // Adjust this value to control the interval for the rectangle rising
float waveSpeed = 0.08; // Adjust this value to control the speed of the wave

Fish fish1 = new Fish(80, 20);

int fishX = 20;
int fishY = 20;


int step = 0;

float randomXLocation[] = new float[100];
float randomYLocation[] = new float[30];

ArrayList<Cloud> clouds = new ArrayList<>();

String stringWithSpecialCharacters = "5yr,360days, 20:07:28";

color oceanColor[][] = new color[30][100];

color fireColor[] = new color[15];

int scaledFrameCount = frameCount - 3750;

int heights[] = new int[150];
int brightness[] = new int[150];

ArrayList<Cloud> CloudList= new ArrayList<Cloud>();

PFont font1;

// some parameters that turned out to work best for the font we're using
float FONT_SIZE = 6;
float FONT_OFFSET_Y = 0.12;
float FONT_SCALE_X = 2.669;
float FONT_SCALE_Y = 2.67;

import java.util.Calendar;
import java.util.Date;

int targetYear = 2029;
int targetMonth = 7;
int targetDay = 22;
int targetHour = 0;
int targetMinute = 0;
int targetSecond = 0;

String countdownText;

void setup() {

  size(1200, 400);
  font1 = createFont("FreePixel.ttf", 9, false);

  aec = new AEC();
  aec.init();

  soundfile = new SoundFile(this, "ars-electronica-final.aiff");

  soundfile.loop();

  for (int y = 0; y < 100; y++) {
    for (int x = 0; x < 100; x++) {
      randomColVal[y][x] = random(0, 50);
    }
  }

  for (int y = 0; y < 100; y++) {
    for (int x = 0; x < 100; x++) {
      randomDarkness[y][x] = random(50, 255);
    }
  }


  for (int x = 0; x < 100; x++) {
    randomXLocation[x] = random(100);
  }

  for (int x = 0; x < 30; x++) {
    randomYLocation[x] = random(30);
  }

  for (int y = 0; y < 30; y++) {
    for (int x = 0; x < 100; x++) {
      int random = (int)random(5);

      if (random == 0) {
        oceanColor[y][x] = color(#2206C6);
      } else if (random == 1) {
        oceanColor[y][x] = color(#3206C6);
      } else if (random == 2) {
        oceanColor[y][x] = color(#3E07F0);
      } else if (random == 3) {
        oceanColor[y][x] = color(#28059B);
      } else if (random == 4) {
        oceanColor[y][x] = color(#1206C7);
      } else if (random == 5) {
        oceanColor[y][x] = color(#3A14B8);
      }
    }
  }

  for (int x =0; x < 150; x++) {
    heights[x] = int(random(1, 2));
  }

  for (int x =0; x < 150; x++) {
    brightness[x] = int(random(0, 255));
  }

  for (int i=0; i<5; i++) {
    CloudList.add(new Cloud(int (random(0, 75)), int (random(0, 28))));
  }

  // Loop through the array to create each Rain object
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Rain();
  }

  fireColor[0] = color(#FBF200);
  fireColor[1] = color(#FBE101);
  fireColor[2] = color(#FCD003);
  fireColor[3] = color(#FCBE04);
  fireColor[4] = color(#FCAD05);
  fireColor[5] = color(#FC9C06);
  fireColor[6] = color(#FD8B08);
  fireColor[7] = color(#FD7A09);
  fireColor[8] = color(#FD680A);
  fireColor[9] = color(#FE570C);
  fireColor[10] = color(#FE460D);
  fireColor[11] = color(#FE350E);
  fireColor[12] = color(#FE230F);
  fireColor[13] = color(#FF1211);
  fireColor[14] = color(#FF0112);
}

void draw() {
  aec.beginDraw();

  background(0, 0, 0);

  noStroke();

  frameRate(60);

  if (frameCount > 0 && frameCount < 600) {
    frameRate(30);
    background(0, 0, 0);
    noStroke();


    fill(#FFFAFE);

    // determines the speed (number of frames between text movements)
    int frameInterval = 3;

    // min and max grid positions at which the text origin should be. we scroll from max (+40) to min (-80)
    int minPos = -150;
    int maxPos = 50;
    int loopFrames = (maxPos-minPos) * frameInterval;

    // vertical grid pos
    int yPos = 15;

    getCountdown();

    displayText(max(minPos, maxPos - (frameCount%loopFrames) / frameInterval), yPos);
  }

  if (frameCount > 600 && frameCount < 800) {
    for (int x = 0; x < 80; x++) {
      for (int y = 0; y < 30; y++) {
        colorMode(RGB);
        fill(0, 0, 0);
        rect(x, y, 1, 1);
      }
    }
  }

  // Rain starts and stops when ocean is full
  if (frameCount  > 800 && frameCount < 1700) {
    for (int i = 0; i < drops.length; i++) {
      drops[i].fall();
    }
  }

  // Ocean is displayed
  drawOcean(900, 25, 28);
  drawOcean(1000, 22, 25);
  drawOcean(1100, 19, 22);
  drawOcean(1200, 16, 19);
  drawOcean(1300, 13, 16);
  drawOcean(1400, 10, 13);
  drawOcean(1500, 10, 13);
  drawOcean(1600, 7, 10);
  drawOcean(1700, 4, 7);

  // Sea creature is displayed
  if (frameCount > 1700 && frameCount  < 3750) {
    fish1.display();
    if (frameCount  % 450 == 0) {
      fish1.grow();
    }

    if (frameCount  % 5 == 0) {
      fish1.update();
    }

    fish1.display();
  }

  // Makes entire facade yellow as large sea creature goes across it
  fillYellow(3400, 75, 65);
  fillYellow(3450, 65, 55);
  fillYellow(3500, 55, 45);
  fillYellow(3550, 45, 35);
  fillYellow(3600, 35, 25);
  fillYellow(3650, 25, 15);
  fillYellow(3700, 15, -1);

  drawSun(0, 10);
  drawSun(10, 20);
  drawSun(20, 30);
  drawSun(30, 40);

  if (frameCount - 3750 > 0 && frameCount - 3750 < 550) {
    for (int x = 40; x < 80; x++) {
      for (int y = 0; y < 30; y++) {
        fill(yellow);
        rect (x, y, 1, 1);
      }
    }
  }

  if (frameCount - 3750 > 550 && frameCount - 3750 < 1150) {
    float pulse = 255 * (1 + sin((frameCount - 3750) * 0.05));
    for (int x = 40; x < 80; x++) {
      for (int y = 0; y < 30; y++) {
        fill(red, pulse);
        rect (x, y, 1, 1);
      }
    }
  }

  if (frameCount - 3750 > 250) {
    drawSun(30, 40);
    changeColorOfRed();
  }

  drawSunWithPulse(0, 10);
  drawSunWithPulse(10, 20);
  drawSunWithPulse(20, 30);
  drawSunWithPulse(30, 40);

  drawLessSun(0);
  drawLessSun(10);
  drawLessSun(20);
  drawLessSun(30);

  drawLesserSun(0);
  drawLesserSun(10);
  drawLesserSun(20);
  drawLesserSun(30);

  drawRedSquare(0);
  drawRedSquare(10);
  drawRedSquare(20);
  drawRedSquare(30);

  colorMode(HSB);

  if (frameCount - 3750 > 1150 && frameCount - 3750 < 1400) {
    fireStart(34, 36);
    fireStart(24, 26);
    fireStart(14, 16);
    fireStart(4, 6);
  }

  colorMode(RGB);

  fireSizeLoop(0, 10);
  fireSizeLoop(10, 20);
  fireSizeLoop(20, 30);
  fireSizeLoop(30, 40);
  fireSizeLoop(40, 80);

  fireDecreaseLoop(0, 10);
  fireDecreaseLoop(10, 20);
  fireDecreaseLoop(20, 30);
  fireDecreaseLoop(30, 40);
  fireDecreaseLoop(40, 80);

  colorMode(HSB);

  if (frameCount - 3750 > 2450 && frameCount - 3750 < 2650) {

    if (frameCount % 10 == 0) {
      CloudList.add(new Cloud(int (random(0, 75)), int (random(0, 28))));
    }

    noStroke();

    for (int i=0; i<CloudList.size(); i++) {
      CloudList.get(i).display();
    }
  }

  if (frameCount - 3750 > 2650 && frameCount - 3750 < 2850) {

    if (frameCount % 7 == 0) {
      CloudList.add(new Cloud(int (random(0, 75)), int (random(0, 28))));
    }

    noStroke();

    for (int i=0; i<CloudList.size(); i++) {
      CloudList.get(i).display();
    }
  }

  if (frameCount - 3750 > 2850 && frameCount - 3750 < 3050) {

    if (frameCount % 2 == 0) {
      CloudList.add(new Cloud(int (random(0, 75)), int (random(0, 28))));
    }

    noStroke();

    for (int i=0; i<CloudList.size(); i++) {
      CloudList.get(i).display();
    }
  }

  if (frameCount - 3750 > 3050 && frameCount - 3750 < 3150) {
    for (int x = 0; x < 80; x++) {
      for (int y = 0; y < 30; y++) {
        colorMode(RGB);
        fill(255, 255, 255);
        rect(x, y, 1, 1);
      }
    }
  }

  if (frameCount - 3750 > 3145) {
    frameRate(30);
    background(0, 0, 0);
    noStroke();

    fill(#FFFAFE);

    // determines the speed (number of frames between text movements)
    int frameInterval = 3;

    // min and max grid positions at which the text origin should be. we scroll from max (+40) to min (-80)
    int minPos = -150;
    int maxPos = 50;
    int loopFrames = (maxPos-minPos) * frameInterval;

    // vertical grid pos
    int yPos = 15;

    getCountdown();

    displayText(max(minPos, maxPos - (frameCount%loopFrames) / frameInterval), yPos);
  }



  colorMode(RGB);

  aec.endDraw();
  aec.drawSides();
}

void keyPressed() {
  aec.keyPressed(key);
}

void drawOcean(int startFrame, int startY, int endY) {
  if (frameCount > startFrame && frameCount < 3750) {
    for (int x = 0; x < 80; x++) {
      for (int y = startY; y < endY; y++) {
        // Calculate wave effect using sin function
        float wave = sin(frameCount * 0.15 + x * 0.15) * 2; // Adjust the multiplier to control the wave amplitude

        // Apply wave effect to the y-coordinate of the rectangle
        int yOffset = y + int(wave);

        fill(oceanColor[y][x]);
        rect(x, yOffset, 1, 4);
      }
    }
  }
}

void fillYellow(int startingFrame, int xValue1, int xValue2) {
  if (frameCount > startingFrame && frameCount  < 3750) {
    for (int x = xValue1; x > xValue2; x--) {
      for (int y = 0; y < 30; y++) {
        fill(#fbf200);
        rect (x, y, 1, 1);
      }
    }
  }
}

void drawSun(int x1, int x2) {
  if (frameCount - 3750 > 0 && frameCount - 3750 < 50) {

    for (int x = x1; x < x2; x++) {
      for (int y = 0; y < 30; y++) {
        fill(yellow);
        rect (x, y, 1, 1);
      }
    }
  }

  if (frameCount - 3750 > 50 && frameCount - 3750 < 100) {
    for (int x = x1 + 1; x < x2 - 1; x++) {
      for (int y = 0; y < 30; y++) {
        fill(yellow);
        rect (x, y, 1, 1);
      }
    }
    fill(yellow);
    rect (x1, 12, 1, 1);
    rect (x2 - 1, 12, 1, 1);
  }

  if (frameCount - 3750 > 100 && frameCount - 3750 < 150) {
    for (int x = x1 + 2; x < x2 - 2; x++) {
      for (int y = 0; y < 30; y++) {
        fill(yellow);
        rect (x, y, 1, 1);
      }
    }

    fill(yellow);
    rect (x1, 12, 1, 1);
    rect (x2 - 1, 12, 1, 1);
    rect (x1 + 1, 5, 1, 1);
    rect (x2 - 2, 5, 1, 1);
    rect (x1 + 1, 19, 1, 1);
    rect (x2 - 2, 19, 1, 1);
  }

  if (frameCount - 3750 > 150 && frameCount - 3750 < 200) {

    for (int x = x1 + 3; x < x2 - 3; x++) {
      for (int y = 0; y < 30; y++) {
        fill(yellow);
        rect (x, y, 1, 1);
      }
    }

    fill(yellow);
    rect (x1, 12, 1, 1);
    rect (x2 - 2, 12, 1, 1);
    rect (x1 + 1, 5, 1, 1);
    rect (x2 - 2, 5, 1, 1);
    rect (x1 + 1, 19, 1, 1);
    rect (x2 - 2, 19, 1, 1);

    for (int i = 9; i < 16; i++) {
      rect (x1 + 2, i, 1, 1);
      rect (x2 - 3, i, 1, 1);
    }
  }

  if (frameCount - 3750 > 200 && frameCount - 3750 < 550) {
    for (int i = 8; i < 17; i++) {
      fill(yellow);
      rect (x1 + 4, i, 1, 1);
      rect (x1 + 3, i, 1, 1);
      rect (x1 + 5, i, 1, 1);
      rect (x1 + 6, i, 1, 1);
    }

    fill(yellow);
    rect (x1, 12, 1, 1);
    rect (x2 - 1, 12, 1, 1);
    rect (x1 + 1, 5, 1, 1);
    rect (x2 - 2, 5, 1, 1);
    rect (x1 + 1, 19, 1, 1);
    rect (x2 - 2, 19, 1, 1);

    for (int i = 9; i < 16; i++) {
      rect (x1 + 2, i, 1, 1);
      rect (x2 - 3, i, 1, 1);
    }

    rect (x1 + 5, 4, 1, 1);
    rect (x1 + 4, 4, 1, 1);

    rect (x1 + 5, 20, 1, 1);
    rect (x1 + 4, 20, 1, 1);
  }
}

void drawSunWithPulse(int x1, int x2) {
  float pulse = 255 * (1 + sin((frameCount - 3750) * 0.05));
  if (frameCount - 3750 > 550 && frameCount - 3750 < 700) {
    for (int i = 8; i < 17; i++) {
      fill(red, pulse);
      rect (x1 + 4, i, 1, 1);
      rect (x1 + 3, i, 1, 1);
      rect (x1 + 5, i, 1, 1);
      rect (x1 + 6, i, 1, 1);
    }

    fill(red, pulse);
    rect (x1, 12, 1, 1);
    rect (x2 - 1, 12, 1, 1);
    rect (x1 + 1, 5, 1, 1);
    rect (x2 - 2, 5, 1, 1);
    rect (x1 + 1, 19, 1, 1);
    rect (x2 - 2, 19, 1, 1);

    for (int i = 9; i < 16; i++) {
      fill(red, pulse);
      rect (x1 + 2, i, 1, 1);
      rect (x2 - 3, i, 1, 1);
    }

    rect (x1 + 5, 4, 1, 1);
    rect (x1 + 4, 4, 1, 1);

    rect (x1 + 5, 20, 1, 1);
    rect (x1 + 4, 20, 1, 1);
  }
}

int num = 1; // Declare the variable outside the function to preserve its value

void changeColorOfRed() {
  if ((frameCount - 3750) % 20 == 0 && num < 15) {
    yellow = fireColor[num];
    num++;
  } else if (num >= 15) {
    yellow = red;
  }
}

void drawLessSun(int x1) {
  float pulse = 255 * (1 + sin((frameCount - 3750) * 0.05));

  if (frameCount - 3750 > 700 && frameCount - 3750 < 850) {
    for (int i = 8; i < 17; i++) {
      fill(red, pulse);
      rect (x1 + 4, i, 1, 1);
      rect (x1 + 3, i, 1, 1);
      rect (x1 + 5, i, 1, 1);
      rect (x1 + 6, i, 1, 1);
    }
  }
}

void drawLesserSun(int x1) {
  float pulse = 255 * (1 + sin((frameCount - 3750) * 0.05));

  if (frameCount - 3750 > 850 && frameCount - 3750 < 950) {
    for (int i = 9; i < 16; i++) {
      fill(red, pulse);
      rect (x1 + 4, i, 1, 1);
      rect (x1 + 5, i, 1, 1);
    }
  }
}

void drawRedSquare(int x1) {
  float pulse = 255 * (1 + sin((frameCount - 3750) * 0.05));

  if (frameCount - 3750 > 950 && frameCount - 3750 < 1150) {
    for (int i = 11; i < 14; i++) {
      fill(red, pulse);
      rect (x1 + 4, i, 1, 1);
      rect (x1 + 5, i, 1, 1);
    }
  }
}


int yIncrement = 0;
void fireStart(int x1, int x2) {
  for (int y = 11 + yIncrement; y < 14 + yIncrement; y++) {
    for (int x = x1; x < x2; x++) {
      if ((scaledFrameCount % 2) == 0) {
        randomColVal[y][x] = random(230, 300);
        randomDarkness[y][x] = random(50, 255);
      }
      fill(randomColVal[y][x], 255, randomDarkness[y][x]);
      rect(x, y, 1, 1);
    }
  }

  if (frameCount % 50 == 0 && yIncrement < 13) {
    yIncrement+=1;
  }
}

void increaseFireSize(int frame, int endFrame, int yLow, int yHigh, int x1, int x2) {
  if (frameCount - 3750 > frame && frameCount - 3750 < endFrame) {
    for (int x = x1; x < x2; x++) {
      if (frameCount % 10 == 0) {
        heights[x] = int(random(yLow, yHigh));
      }

      int bright = int(random(0, 255));

      for (int i = 0; i < heights[x]; i++) {

        fill(255, bright, 0);
        rect(x, 24 - i, 1, 1);
      }
    }
  }
}

void fireSizeLoop(int x1, int x2) {
  increaseFireSize(1350, 1400, 1, 3, x1, x2);
  increaseFireSize(1400, 1450, 2, 4, x1, x2);
  increaseFireSize(1450, 1500, 3, 6, x1, x2);
  increaseFireSize(1500, 1550, 4, 10, x1, x2);
  increaseFireSize(1550, 1600, 6, 12, x1, x2);
  increaseFireSize(1600, 1650, 7, 15, x1, x2);
  increaseFireSize(1650, 1700, 9, 20, x1, x2);
  increaseFireSize(1700, 1750, 12, 25, x1, x2);
  increaseFireSize(1750, 1800, 14, 25, x1, x2);
  increaseFireSize(1800, 1850, 18, 25, x1, x2);
  increaseFireSize(1850, 1900, 20, 25, x1, x2);
}

void fireDecreaseLoop(int x1, int x2) {
  increaseFireSize(2400, 2450, 1, 3, x1, x2);
  increaseFireSize(2350, 2400, 2, 4, x1, x2);
  increaseFireSize(2300, 2350, 3, 6, x1, x2);
  increaseFireSize(2250, 2300, 4, 10, x1, x2);
  increaseFireSize(2200, 2250, 6, 12, x1, x2);
  increaseFireSize(2150, 2200, 7, 15, x1, x2);
  increaseFireSize(2100, 2150, 9, 20, x1, x2);
  increaseFireSize(2050, 2100, 12, 25, x1, x2);
  increaseFireSize(2000, 2050, 14, 25, x1, x2);
  increaseFireSize(1950, 2000, 18, 25, x1, x2);
  increaseFireSize(1900, 1950, 20, 25, x1, x2);
}

void displayText(int x, int y)
{
  // push & translate to the text origin
  pushMatrix();
  translate(x, y+FONT_OFFSET_Y);

  // scale the font up by fixed paramteres so it fits our grid
  scale(FONT_SCALE_X, FONT_SCALE_Y);
  textFont(font1);
  textSize(FONT_SIZE);

  // draw the font glyph by glyph, because the default kerning doesn't align with our grid
  for (int i = 0; i < countdownText.length(); i++)
  {
    text(countdownText.charAt(i), (float)i*3, 0);
  }

  popMatrix();
}

void getCountdown() {

  long targetTime = getTimeInMillis(targetYear, targetMonth, targetDay, targetHour, targetMinute, targetSecond);
  long remainingTime = targetTime;
  println("targetTime: " + targetTime);

  if (remainingTime <= 0) {
    remainingTime = 0;
  }

  int years = (int) (remainingTime / (1000L * 60 * 60 * 24 * 365));
  println("years" + years);

  remainingTime -= years * (1000L * 60 * 60 * 24 * 365);

  int days = (int) (remainingTime / (1000L * 60 * 60 * 24));
  remainingTime -= days * (1000L * 60 * 60 * 24);

  int hours = (int) (remainingTime / (1000L * 60 * 60));
  remainingTime -= hours * (1000L * 60 * 60);

  int minutes = (int) (remainingTime / (1000L * 60));
  remainingTime -= minutes * (1000L * 60);

  int seconds = (int) (remainingTime / 1000L);

  countdownText = nf(years, 2) + "y " + nf(days, 2) + "d " + nf(hours, 2) + ":" + nf(minutes, 2) + ":" + nf(seconds, 2);
}


long getTimeInMillis(int year, int month, int day, int hour, int minute, int second) {
  Calendar calendar = Calendar.getInstance();
  long todayDifference = calendar.getTimeInMillis();
  calendar.set(year, month - 1, day, hour, minute, second);
  return calendar.getTimeInMillis() - todayDifference;
}
