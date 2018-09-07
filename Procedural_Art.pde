int res = 30;

float mOffset = 0;
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
  
  for(int x = 0; x <= width; x += res)
  {
    float hThis = noise((map(x, 0, width, 0, width/res)+mOffset) * 0.04f);
    float hNext = noise((map(x+res, 0, width, 0, width/res)+mOffset) * 0.04f);
    beginShape(TRIANGLE_STRIP);
    for(int y = 0; y <= height; y += res)
    {
      fill(map(y, 0, height, 0, 255/2));
      stroke(map(y, 0, height, 0, 255/2));
      vertex(x, height-(y*hThis));
      vertex(x+res, height-(y*hNext));
    }
    endShape();
  }
}
