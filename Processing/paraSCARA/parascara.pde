import processing.serial.*; 

Serial port = new Serial(this, Serial.list()[3], 9600);   
boolean click = false;
int mode = 0;
float a = 53.5, b = 90, m = 18, l;
float x, y, x1, x2, x3, x4, y1, y2, y3, y4, xl, yl, t0, t1, t2, i=0, loop=0;
int h = 500, w = 500; 

void setup(){
  size(w,h);
}

void draw(){
  pushMatrix();
  translate(w/2,-h/2);
  background(255);
  stroke(0);
  noFill();
  line(0,0,0,2*h);
  line(-w,h,w,h);
  ellipse(-m,h,2*(a+b),2*(a+b));
  ellipse(m,h,2*(a+b),2*(a+b));
  ellipse(-m,h,2*abs(a-b),2*abs(a-b));
  ellipse(m,h,2*abs(a-b),2*abs(a-b));
  
  switch (mode){
    case 0:
      x = mouseX - w/2; 
      y = h - mouseY - h/2;
      break;
    case 1:
      x = 30*cos(i);
      y = 30*sin(i)+100;
      i = i + 0.3;
      break;
  }
 
//left arm
  l = sqrt(sq(m+x)+sq(y)); // distance between origin and (x,y)
  t0 = atan2(y,x+m); // angle to l 
  t1 = acos((sq(l)+sq(a)-sq(b))/(2*a*l));
  x1 = a*cos(t1+t0);
  y1 = a*sin(t1+t0);
  line(-m,h,-m+x1,h-y1);
  line(-m+x1,h-y1,x,h-y); 
  ellipse(-m+x1,(h-y1),10,10);
  //print(sqrt(sq((-m+x1)-(x))+sq((y1)-(y)))," ");
  print(x," ",y," |");
  print(degrees(t0+t1)," ");
  
//right arm
  l = sqrt(sq(m-x)+sq(y));
  t0 = atan2(y,x-m);
  t1 = acos((sq(l)+sq(a)-sq(b))/(2*a*l));
  x3 = a*cos(t0-t1);
  y3 = a*sin(t0-t1);
  line(m,h,m+x3,h-y3);
  line(m+x3,h-y3,x,h-y); 
  ellipse(m+x3,(h-y3),10,10);
  //println(sqrt(sq((m+x3)-(x))+sq((y3)-(y))));
  println(degrees(t0-t1));
  
  if (click){
    String[] data = {str(1234),",",str(4321),"\n"};
    port.write(join(data,""));
    println("zeroing-------------------------------|");
    click = false;
  }
  else if(loop==20 && mode == 0) {
    String[] data = {str(x),",",str(y),"\n"};
    port.write(join(data,""));
    loop=0;
  }
  
  if (mode != 0){
    String[] data = {str(x),",",str(y),"\n"};
    port.write(join(data,""));
    loop=0;
    delay(80);
  } 
  popMatrix();
  loop++;
}

void mouseClicked() {
  click = true;
}

