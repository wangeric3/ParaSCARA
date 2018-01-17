boolean click = false;
int mode = 0;
float a = 100, b = 100;
int h = 800, w = 500;
float x, y, dy=0, x0=0, y0=0, x1, x2, y1, y2, t1, t2, i=0;

void setup(){
  size(w,h);
}

void draw(){
  pushMatrix();
  translate(w/2,-h/4);
  background(255);
  stroke(0);
  noFill();
  ellipse(x0,h-y0,2*(a+b),2*(a+b));
  ellipse(x0,h-y0,2*abs(a-b),2*abs(a-b));
  
  switch (mode){
    case 0:
      x = mouseX - w/2; 
      y = h - mouseY - h/4;
      break;
    case 1:
      x = 50*cos(i)+200;
      y = 50*sin(pow(i,3))+200;
      i = i + 0.3;
      break;
    case 2:
      x = 100; 
      y = 400;
      break;
    case 3:
      x = 100; 
      y = 100;
      break;
  }

  if (y<y0){
    y0 = y-10; 
  } else if(sqrt(sq(x-x0)+sq(y-y0))>a+b-10) {
    dy = y0-y-100;
    y0 = y-sqrt(abs(sq(a+b-10)-sq(x)));
  }

  y -= y0;
  
  println(x,y);

  t1 = acos((sq(x)+sq(y)+sq(a)-sq(b))/(2*a*sqrt(sq(x)+sq(y))))+atan2(y,x);
  t2 = acos((-sq(x)-sq(y)+sq(b)+sq(a))/(2*b*a));
    
    
  x1 = a*cos(t1);
  y1 = a*sin(t1);
  x2 = b*cos(t1-PI+t2);
  y2 = b*sin(t1-PI+t2);

  line(x0,h-y0,x1,h-y1-y0);
  line(x1,h-y1-y0,x1+x2,h-y1-y2-y0); 
  ellipse(x1,(h-y1-y0),10,10);
  if(click) fill(255,0,0);
  ellipse(x1+x2,h-y1-y2-y0,10,10);
  //mode = 3;
  //print(degrees(t1),degrees(t2),degrees(t1-PI+t2),"\n");
  if (mode != 0) delay(50);
  popMatrix();
}

  
//line(400,500-200,x1+400,500-y1-200);
//line(600,500-200,x2+600,500-y2-200); 
void mouseClicked() {
  if (click){
    click = false;
  } else {
    click = true;
  }
}

