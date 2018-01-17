boolean click = false;
int mode = 0;
float l=200;
int h = 800, w = 500;
float x, y, x1, y1, t1, i=0, d;

void setup(){
  size(w,h);
}

void draw(){
  pushMatrix();
  translate(w/2,-h/4);
  background(255);
  stroke(0);
  noFill();
  line(l,h+h/4,l,0);
  line(-l,h+h/4,-l,0);
  
  switch (mode){
    case 0:
      x = mouseX-w/2; 
      y = h-mouseY-h/4;
      break;
    case 1:
      x = 50*cos(i);
      y = 50*sin(i);
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

  ellipse(0,h-d,2*l,2*l);
 
  t1 = acos(x/l);
  d = y-l*sin(t1);
  println(degrees(t1),d);
  
  x1 = l*cos(t1);
  y1 = y;
  
  line(0,h-d,x1,h-y1);
  if(click) fill(255,0,0);
  ellipse(x1,h-y1,10,10);
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

