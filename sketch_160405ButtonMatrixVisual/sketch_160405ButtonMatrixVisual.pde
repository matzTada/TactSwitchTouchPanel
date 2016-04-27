/* 
 with ButtonMatrix by Arduino
 to visualize the button matrix like "Touch Panel"
 */

import processing.serial.*;

int NUM_SERIAL = 4;
int NUM_SENSOR_PER_SERIAL = 16;
int diameter;

Serial[] myPorts = new Serial[NUM_SERIAL];

int[][] buttons = new int[NUM_SERIAL][NUM_SENSOR_PER_SERIAL]; 

void setup() {
  //size(200, 200);
  size(800, 800);
  //size(1600, 1600);
  println(Serial.list());

  for (int i = 0; i < myPorts.length; i++) {
    myPorts[i] = new Serial(this, Serial.list()[i], 9600);
    myPorts[i].bufferUntil('\n');
  }

  ellipseMode(CORNER);
  diameter = width / (int(sqrt(NUM_SERIAL)) * int(sqrt(NUM_SENSOR_PER_SERIAL)));
}   

void draw() {
  for (int j = 0; j < NUM_SERIAL; j++) {
    for (int i = 0; i < NUM_SENSOR_PER_SERIAL; i ++) {
      if (buttons[j][i] == 0) fill(255); //pressed!!!
      else fill(255, 0, 0);
      ellipse(j % int(sqrt(NUM_SERIAL)) * int(sqrt(NUM_SENSOR_PER_SERIAL)) * diameter+ i % int(sqrt(NUM_SENSOR_PER_SERIAL)) * diameter, 
        j / int(sqrt(NUM_SERIAL)) * int(sqrt(NUM_SENSOR_PER_SERIAL)) * diameter + i /int(sqrt(NUM_SENSOR_PER_SERIAL)) * diameter, 
        diameter, diameter);
    }
  }
}

void serialEvent(Serial myPort) {
  try {
    String myString = myPort.readStringUntil('\n');
    myString = trim(myString);
    //println(myString);
    int tmp[] = int(split(myString, ','));
    if (tmp.length > 0) {
      int id = tmp[0];
      //println("Signal from: " + id);
      for (int i = 0; i < NUM_SENSOR_PER_SERIAL; i++) {
        buttons[id][i] = tmp[i + 1];
      }
    }
  }
  catch(Exception e) {
    println(e);
  }
}

void keyPressed() {
  for (int i = 0; i < myPorts.length; i++) {
    myPorts[i].clear();
    myPorts[i].stop();
  }

  exit();
  switch(key) {
  case 'r':
    break;
  case 'a':
    break;  
  case 'A':
    break;
  default: 
    break;
  }
}