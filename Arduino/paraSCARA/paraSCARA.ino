#include <Math.h>

const int dir_pin1 = 3, dir_pin2 = 5;
const int step_pin1 = 7, step_pin2 = 6;
const int a = 53.5, b = 90, m = 18;
int iter = 0;
float t1 = PI, t2 = PI, t1_next=0, t2_next=0, d1 = 0, d2 = 0, x_pos=0, y_pos=0;
float x_coords[4] = {-40,40,40,-40};
float y_coords[4] = {100,100,50,50};

void setup() {
  pinMode(dir_pin1, OUTPUT);
  pinMode(dir_pin2, OUTPUT);
  pinMode(step_pin1, OUTPUT);
  pinMode(step_pin2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
//  parseSerial();
//  inverse(x_pos,y_pos);
//  if (x_pos==1234.0 && y_pos==4321.0) {
//    t1 = PI; t2 = PI;
//  }
//  else if (!isnan(t1_next) && !isnan(t2_next)){
//    if (t1_next-t1 <= 0) d1 = LOW;
//    else d1 = HIGH;
//    if (t2_next-t2 <= 0) d2 = HIGH;
//    else d2 = LOW;    
//
//    moveSteppers(steps(abs(t1_next-t1)), d1, steps(abs(t2_next-t2)), d2);
//    t1 = t1_next;
//    t2 = t2_next; 
//  }
//  

//   moveSteppers(steps(PI/2),HIGH,steps(PI/2),HIGH);
//   delay(500);
//   moveSteppers(steps(PI/2),LOW,steps(PI/2),LOW);
// delay(500);
  pinMode(step_pin1,HIGH);

 // moveStepper1(steps(PI/2)*16,HIGH);
}

void moveSteppers(float steps1, int dir1, float steps2, int dir2){
  digitalWrite(dir_pin1, dir1);
  digitalWrite(dir_pin2, dir2);
  digitalWrite(step_pin1,LOW);
  digitalWrite(step_pin2,LOW);
  float alpha = max(steps1,steps2), beta = min(steps1,steps2);
  for (int i=0;i<max(steps1,steps2);i++){
     if(i<steps1) digitalWrite(step_pin1,HIGH);
     if(i<steps2) digitalWrite(step_pin2,HIGH);
     delayMicroseconds(200);
     digitalWrite(step_pin1,LOW);
     digitalWrite(step_pin2,LOW);
     delayMicroseconds(200);
     
  }
}


void moveStepper1(int steps1, int dir1){
  digitalWrite(dir_pin1, dir1);
  digitalWrite(step_pin1,LOW);
  for (int i=0;i<steps1;i++){
     digitalWrite(step_pin1,HIGH);
     delayMicroseconds(100);
     digitalWrite(step_pin1,LOW);
     delayMicroseconds(100);
  }
}

void inverse(float x, float y) {
  float l1, l2;
  //left arm
  l1 = sqrt(sq(m+x)+sq(y)); // distance between origin and (x,y)
  t1_next = acos((sq(l1)+sq(a)-square(b))/(2*a*l1)) + atan2(y,x+m);
  

  //right arm
  l2 = sqrt(sq(m-x)+sq(y));
  t2_next = PI - (atan2(y,x-m) - acos((sq(l2)+sq(a)-square(b))/(2*a*l2)));

//  if (t1_next<0) t1_next += 2*PI;
//  if (t2_next<0) t2_next += 2*PI;
  
  Serial.print(degrees(t1_next));
  Serial.print(" ");
  Serial.println(degrees(t2_next));
}

void forward(float j1, float j2){
  x_pos = a*cos(j1) + b*cos(j1+j2);  
  y_pos = a*sin(j1) + b*sin(j1+j2);  
}


float steps(float deg){
  return deg*180*16/(1.8*PI);  
}

void parseSerial(){
    bool endData = false;
    char c;
    char x_array[32], y_array[32];
    int comma = 100;
    for(int i=0;i<32;i++){
      x_array[i] = 0;
      y_array[i] = 0;
    }
    int i = 0;
      while (endData == false){
        while(!Serial.available());
        c = Serial.read();
        if (c != '\n'){
          if (c == ',') {
            comma = i;
            i++;
            continue;
          }
          if (i>comma) y_array[i-comma-1] = c;
          else x_array[i] = c;
          i++;
        } else {
          endData = true;
        }
        
      }
    if (i!=0){
    Serial.print(i);
    Serial.print(" ");
    x_pos = atof(x_array);
    y_pos = atof(y_array);
    Serial.print(x_pos);
    Serial.print(" ");
    Serial.println(y_pos);}
}

void parseCoords(int iter){
    x_pos = x_coords[iter];
    y_pos = y_coords[iter];
    Serial.print(iter);
    Serial.print(" ");
    Serial.print(x_pos);
    Serial.print(" ");
    Serial.println(y_pos);
}




