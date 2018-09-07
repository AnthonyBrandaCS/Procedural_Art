enum Ter { water, mountain };

int res = 30;

float wOffset = 1;
float wSpeed = 0.25f;

float mOffset = 1;
float mSpeed = 0.1f;

void setup()
{
  //fullScreen();
  size(800, 600);
  frameRate(20);
}
void draw()
{
  background(0);
  water();
  mountains();
}

void water()
{
  wOffset -= wSpeed;
  
  for(int x = 0; x <= width; x += res)
  {
    float hThis = map(sin(x+wOffset), -1, 1, 0.375, 0.4);
    float hNext = map(sin(x+res+wOffset), -1, 1, 0.375, 0.4);
    
    drawMesh(x, hThis, hNext, Ter.water);
  }
}

void mountains()
{
  mOffset += mSpeed;
  
  for(int x = 0; x <= width; x += res)
  {
    float hThis = noise((map(x, 0, width, 0, width/res)+mOffset) * 0.04f);
    float hNext = noise((map(x+res, 0, width, 0, width/res)+mOffset) * 0.04f);
    
    drawMesh(x, hThis, hNext, Ter.mountain);
  }
}

void drawMesh(int x, float hThis, float hNext, Ter type)
{
  beginShape(TRIANGLE_STRIP);
  for(int y = 0; y <= height; y += res)
  {
    switch(type)
    {
      case water:
        fill(0, 0, map(y, 0, height, 0, 255/1.25f));
        stroke(0, 0, map(y, 0, height, 0, 255/1.25f));
        break;
      case mountain:
        fill(map(y, 0, height, 0, 255/2));
        stroke(map(y, 0, height, 0, 255/2));
        break;
    }
    vertex(x, height-(y*hThis));
    vertex(x+res, height-(y*hNext));
  }
  endShape();
}
