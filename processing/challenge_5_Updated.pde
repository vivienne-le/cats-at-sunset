int catHead = 50;
int catBodyWidth = 60;
float sunsetProgress = 0;
float sunY = 200;
float moonY = 600; // start moon at bottom of screen
boolean showHeartCat1 = false;
boolean showHeartCat2 = false;
boolean sunHasSet = false; // track if the sun has set

// defined arrays for the glistening dots on water
int numDots = 50;
float[] dotX = new float[numDots];
float[] dotY = new float[numDots];
float[] dotSpeedX = new float[numDots];
float[] dotSpeedY = new float[numDots];

void setup(){
  size(600, 600);
  noStroke();  
  frameRate(60);

  // initialize positions and speeds for the glistening dots
  for (int i = 0; i < numDots; i++) {
    dotX[i] = random(width);  // random initial x position
    dotY[i] = random(350, 500);  // y position within the water
    dotSpeedX[i] = random(-0.5, 0.5);  // horizontal movement speed
    dotSpeedY[i] = random(-0.2, 0.2);  // vertical movement speed
  }
}

void draw(){
  // animated sunset with gradient background
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color startColor = lerpColor(color(255, 204, 102), color(102, 51, 153), sunsetProgress);
    color endColor = lerpColor(color(0, 102, 204), color(0, 0, 51), sunsetProgress);
    color c = lerpColor(startColor, endColor, inter);
    fill(c);  // use fill instead of stroke for the background
    rect(0, i, width, 1); // draw line equivalent without stroke
  }

  // draw the sun or moon
  if (!sunHasSet) {
    fill(255, 204, 0);  // sun color
    ellipse(width / 2, sunY, 80, 80);
    sunY += 0.5;
    if (sunY > height) {
      sunY = height;
      sunHasSet = true; // mark sun as set
    }
  } else {
    // moon rising after sun has set
    fill(220, 220, 255);  // moon color
    ellipse(width / 2, moonY, 60, 60);
    if (moonY > 150) {
      moonY -= 0.5; // move moon up gradually
    }
  }

  sunsetProgress += 0.001;
  if (sunsetProgress > 1) sunsetProgress = 1;

  // water
  fill(137, 207, 240);
  rect(0, 350, width, 600);
  
  // sand
  fill(240, 230, 140);
  rect(0, 500, width, 600);
  
  // draw moving glistening dots on the water
  drawGlisteningDots();

  // cats color
  fill(0);
  
  // cat #1
  ellipse(250, 450, catHead, catHead); //head
  ellipse(250, 500, catBodyWidth, 90); //body
  triangle(228, 440, 229, 418, 243, 429);
  triangle(258, 428, 270, 418, 272, 440); //ears
  rect(168, 535, 80, 10, 50); //tail

  // display heart above cat #1 if clicked
  if (showHeartCat1) {
    drawHeart(250, 400); // move heart down by 50 pixels
  }
  
  // cat #2
  fill(0); // ensure cat #2 is always black -- without this the cat turns red for some reason
  ellipse(320, 460, catHead, catHead);
  ellipse(320, 510, catBodyWidth, 70);
  triangle(300, 448, 301, 425, 315, 440);
  triangle(324, 448, 340, 425, 341, 450);
  rect(320, 535, 70, 10, 50);

  // display heart above cat #2 if clicked
  if (showHeartCat2) {
    drawHeart(320, 410); 
  }
}

// function to draw a heart shape
void drawHeart(float x, float y) {
  fill(255, 0, 0);  // Heart color
  beginShape();
  vertex(x, y);
  bezierVertex(x - 10, y - 10, x - 20, y + 5, x, y + 20);
  bezierVertex(x + 20, y + 5, x + 10, y - 10, x, y);
  endShape(CLOSE);
}

//function to draw and animate the glistening dots on the water
void drawGlisteningDots() {
  fill(255);  // dots color
  for (int i = 0; i < numDots; i++) {
    ellipse(dotX[i], dotY[i], 5, 5);  // each dot is a small circle
    // update the position of each dot to create a glistening effect
    dotX[i] += dotSpeedX[i];
    dotY[i] += dotSpeedY[i];
    
    // dot spawns at random position when it moves out of the water/screen
    if (dotX[i] > width || dotX[i] < 0) {
      dotX[i] = random(width);
      dotY[i] = random(350, 500);  // keep it within the water region
    }
    if (dotY[i] > 500 || dotY[i] < 350) {
      dotSpeedY[i] *= -1;  // reverse direction vertically
    }
  }
}

void mousePressed() {
  // check if mouse is over cat #1
  if (dist(mouseX, mouseY, 250, 450) < catHead / 2) {
    showHeartCat1 = !showHeartCat1; // toggle heart for cat #1
  }
  
  // check if mouse is over cat #2
  if (dist(mouseX, mouseY, 320, 460) < catHead / 2) {
    showHeartCat2 = !showHeartCat2; // toggle heart for cat #2
  }
}
