enum Ter { water, mountain };

int res = 30;

float wOffset = 1;
float wSpeed = 0.25f;
float wThis, wNext;

float mOffset = 1;
float mSpeed = 0.1f;
float mThis, mNext;

void setup()
{
  //fullScreen();
  size(800, 600);
  frameRate(24);
}
void draw()
{
  mOffset += mSpeed;
  wOffset -= wSpeed;
  background(0);
  
  for(int x = 0; x <= width; x += res)
  {
    wThis = map(sin(x+wOffset), -1, 1, 0.375, 0.4);
    wNext = map(sin(x+res+wOffset), -1, 1, 0.375, 0.4);
    
    mThis = noise((map(x, 0, width, 0, width/res)+mOffset) * 0.04f);
    mNext = noise((map(x+res, 0, width, 0, width/res)+mOffset) * 0.04f);
    
    if(wThis > mThis || wNext > mNext)
      drawMesh(x, wThis, wNext, Ter.water);
    
    drawMesh(x, mThis, mNext, Ter.mountain);
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
