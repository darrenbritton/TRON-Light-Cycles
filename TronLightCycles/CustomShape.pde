public void stretechedOctagonThing(boolean fillme, int thickness)
{
  strokeWeight(thickness);
  stroke(230, 255, 255);
  fill(40, 40, 40);
  if (fillme == false)
  {
    noFill();
  }
  beginShape(); 
  vertex(a.x, a.y); 
  vertex(b.x, b.y); 
  vertex(c.x, c.y);
  vertex(d.x, d.y);
  vertex(e.x, e.y);
  vertex(f.x, f.y); 
  vertex(g.x, g.y); 
  vertex(h.x, h.y); 
  vertex(a.x, a.y);
  endShape();
}

public void lightStream(color streamColor, PVector one, PVector two, PVector three, PVector four)
{
  fill(streamColor);
  stroke(streamColor);
  beginShape();
  vertex(one.x, one.y);
  vertex(two.x, two.y);
  vertex(four.x, four.y);
  vertex(three.x, three.y);
  vertex(one.x, one.y);
  endShape();
}


public void polygon(int n, float cx, float cy, float r)
{
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}

