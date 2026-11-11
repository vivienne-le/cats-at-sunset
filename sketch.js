// p5.js version of challenge_5_Updated.pde

let catHead = 50;
let catBodyWidth = 60;
let sunsetProgress = 0;
let sunY = 200;
let moonY = 600; // start moon at bottom of screen
let showHeartCat1 = false;
let showHeartCat2 = false;
let sunHasSet = false; // track if the sun has set

// arrays for the glistening dots on water
let numDots = 50;
let dotX = [];
let dotY = [];
let dotSpeedX = [];
let dotSpeedY = [];

function setup() {
  createCanvas(600, 600).parent('stage');
  noStroke();
  frameRate(60);

  // initialize positions and speeds for the glistening dots
  for (let i = 0; i < numDots; i++) {
    dotX[i] = random(width);  // random initial x position
    dotY[i] = random(350, 500);  // y position within the water
    dotSpeedX[i] = random(-0.5, 0.5);  // horizontal movement speed
    dotSpeedY[i] = random(-0.2, 0.2);  // vertical movement speed
  }
}

function draw() {
  // animated sunset with gradient background
  for (let i = 0; i < height; i++) {
    let inter = map(i, 0, height, 0, 1);
    let startColor = lerpColor(color(255, 204, 102), color(102, 51, 153), sunsetProgress);
    let endColor = lerpColor(color(0, 102, 204), color(0, 0, 51), sunsetProgress);
    fill(lerpColor(startColor, endColor, inter));
    rect(0, i, width, 1);
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

  drawGlisteningDots();

  // cats color
  fill(0);

  // cat #1
  ellipse(250, 450, catHead, catHead); // head
  ellipse(250, 500, catBodyWidth, 90); // body
  triangle(228, 440, 229, 418, 243, 429);
  triangle(258, 428, 270, 418, 272, 440); // ears
  rect(168, 535, 80, 10, 50); // tail

  if (showHeartCat1) {
    drawHeart(250, 400);
  }

  // cat #2
  fill(0);
  ellipse(320, 460, catHead, catHead);
  ellipse(320, 510, catBodyWidth, 70);
  triangle(300, 448, 301, 425, 315, 440);
  triangle(324, 448, 340, 425, 341, 450);
  rect(320, 535, 70, 10, 50);

  if (showHeartCat2) {
    drawHeart(320, 410);
  }
}

function drawHeart(x, y) {
  fill(255, 0, 0);
  beginShape();
  vertex(x, y);
  bezierVertex(x - 10, y - 10, x - 20, y + 5, x, y + 20);
  bezierVertex(x + 20, y + 5, x + 10, y - 10, x, y);
  endShape(CLOSE);
}

function drawGlisteningDots() {
  fill(255);
  for (let i = 0; i < numDots; i++) {
    ellipse(dotX[i], dotY[i], 5, 5);
    dotX[i] += dotSpeedX[i];
    dotY[i] += dotSpeedY[i];

    // dot spawns at random position when it moves out of the water/screen
    if (dotX[i] > width || dotX[i] < 0) {
      dotX[i] = random(width);
      dotY[i] = random(350, 500);
    }
    if (dotY[i] > 500 || dotY[i] < 350) {
      dotSpeedY[i] *= -1; // reverse direction vertically
    }
  }
}

function mousePressed() {
  // check if mouse is over cat #1
  if (dist(mouseX, mouseY, 250, 450) < catHead / 2) {
    showHeartCat1 = !showHeartCat1;
  }

  // check if mouse is over cat #2
  if (dist(mouseX, mouseY, 320, 460) < catHead / 2) {
    showHeartCat2 = !showHeartCat2;
  }
}

function restart() {
  sunsetProgress = 0;
  sunY = 200;
  moonY = 600;
  sunHasSet = false;
}
