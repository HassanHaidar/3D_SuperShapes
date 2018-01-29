import g4p_controls.*;

import peasy.*;
PeasyCam cam;
int resol = 100;
PVector[][] points;



float a = 1;
float b = 1;
float n1 = 0.5;
float n2 = 0.5;
float n3 = 8;
float m1;
float m2;
float counter;



void setup(){
  size(600,600, P3D);
  cam = new PeasyCam(this, 500);
  points = new PVector[resol + 1][resol + 1];
}

void draw(){
  


  background(0);
  fill(255);
  lights();
  float scale = 200;
  m1 = m2;
  m2 = map(sin(counter), -1, 1, 0, 7);
  counter += 0.02;
  
  for (int i  = 0; i <= resol;  i++ ){
    float phi = map(i, 0, resol, -PI, PI);
    float r1 = sf(phi);
     for (int j  = 0; j <= resol;  j++ ){
       float theta = map(j, 0, resol, -PI/2, PI/2);
       float r2 = sf(theta);
       float x = scale*r1*cos(phi)*r2*cos(theta);
       float y = scale*r1*sin(phi)*r2*cos(theta);
       float z = scale * r2 * sin(theta);
       points[i][j] = new PVector(x,y,z);
    }
  }
  
  for (int i  = 0; i < resol;  i++ ){
    beginShape(TRIANGLE_STRIP);
     for (int j  = 0; j <= resol;  j++ ){
       PVector c1 = points[i][j];
       stroke(255);
       vertex(c1.x, c1.y, c1.z);
       PVector c2 = points[i + 1][j];
       vertex(c2.x, c2.y, c2.z);
     }
     endShape();
  }
  
  counter += 0.005;
}
float sf(float angle){
    float part1 = pow(abs(cos(m1*angle/4)/a), n2);
    float part2 = pow(abs(sin(m2*angle/4)/b), n3);
    float r = pow((part1 + part2), (-1 / n1));
  return r;
}