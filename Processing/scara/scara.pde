boolean click = false;
int mode = 0;
float a = 100, b = 100;
float x, y, x1, x2, x3, x4, y1, y2, y3, y4, t0, t1, t2, i=0;
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
  ellipse(0,h,2*(a+b),2*(a+b));
  ellipse(0,h,2*abs(a-b),2*abs(a-b));
  
  switch (mode){
    case 0:
      x = mouseX - w/2; 
      y = h - mouseY - h/2;
      break;
    case 1:
      x = 50*cos(i)+200;
      y = 50*sin(pow(i,3))+200;
      i = i + 0.3;
      break;
  }

  t0 = atan2(y,x); // angle to line between origin and (x,y)
  t1 = acos((sq(x)+sq(y)+sq(a)-sq(b))/(2*a*sqrt(sq(x)+sq(y))));
  t2 = acos((-sq(x)-sq(y)+sq(b)+sq(a))/(2*b*a));
    
    
  x1 = a*cos(t1+t0);
  y1 = a*sin(t1+t0);
  x2 = b*cos(t1+t0-PI+t2);
  y2 = b*sin(t1+t0-PI+t2);
  
  line(0,h,x1,h-y1);
  line(x1,h-y1,x1+x2,h-y1-y2); 
  ellipse(x1,(h-y1),10,10);
 
//  x3 = a*cos(t0-t1);
//  y3 = a*sin(t0-t1);
//  x4 = b*cos(PI-t2+(t0-t1));
//  y4 = b*sin(PI-t2+(t0-t1));
//  
//  line(0,h,x3,h-y3);
//  line(x3,h-y3,x3+x4,h-y3-y4); 
//  ellipse(x3,(h-y3),10,10);
 
  if(click) fill(255,0,0);
  ellipse(x1+x2,h-y1-y2,10,10);

  print(degrees(t1),degrees(t2),degrees(t1-PI+t2),"\n");
  if (mode != 0) delay(50);
  popMatrix();
}

void mouseClicked() {
  if (click){
    click = false;
  } else {
    click = true;
  }
}

