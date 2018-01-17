boolean click = false;
int mode = 0;
float a = 100, b = 200, m = 50, l;
float x, y, x1, x2, x3, x4, y1, y2, y3, y4, xl, yl, t0, t1, t2, i=0;
int h = 800, w = 800;
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
      x = 50*cos(i);
      y = 50*sin(pow(i,3))+100;
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
  print(sqrt(sq((-m+x1)-(x))+sq((y1)-(y)))," ");
  
//right arm
  l = sqrt(sq(m-x)+sq(y));
  t0 = atan2(y,x-m);
  t1 = acos((sq(l)+sq(a)-sq(b))/(2*a*l));
  x3 = a*cos(t0-t1);
  y3 = a*sin(t0-t1);
  line(m,h,m+x3,h-y3);
  line(m+x3,h-y3,x,h-y); 
  ellipse(m+x3,(h-y3),10,10);
  println(sqrt(sq((m+x3)-(x))+sq((y3)-(y))));

  if(click) fill(255,0,0);
  ellipse(x,y,10,10);

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

