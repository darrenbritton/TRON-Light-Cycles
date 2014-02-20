class AI
{
  color AIcolor;
  PVector location;
  int dir;

  AI()
  {
    AIcolor = color(tronOrange);

    location = new PVector(0, 0);

    dir = LEFT;
  }

  AI(color AIcolor, PVector location)
  {
    this.AIcolor = AIcolor;

    this.location = location;

    dir = LEFT;
  }

  void draw()
  {
    stroke(AIcolor);
    point(int(location.x), int(location.y));
    if (dir == LEFT)
    {
      location.x--;
      if (get(int(location.x-1), int(location.y)) != color(0, 0, 0))
      {
        if (get(int(location.x), int(location.y-1)) == color(0, 0, 0) && get(int(location.x), int(location.y+1)) == color(0, 0, 0))
        {
          rand = random(0, 2);
          if (rand > 1)
          {
            dir = UP;
          }
          else
          {
            dir = DOWN;
          }
        }
        else if (get(int(location.x), int(location.y+1)) == color(0, 0, 0))
        {
          dir = DOWN;
        }
        else if (get(int(location.x), int(location.y-1)) == color(0, 0, 0))
        {
          dir = UP;
        }
        else
        {
          dir = -1;
        }
      }
    }
    else if (dir == RIGHT)
    {
      location.x++;
      if (get (int(location.x+1), int(location.y)) != color(0, 0, 0))
      {
        if (get(int(location.x), int(location.y+1)) == color(0, 0, 0) && get(int(location.x), int(location.y-1)) == color(0, 0, 0))
        {
          rand = random(0, 2);
          if (rand > 1)
          {
            dir = DOWN;
          }
          else
          {
            dir = UP;
          }
        }
        else if (get(int(location.x), int(location.y+1)) == color(0, 0, 0))
        {
          dir = DOWN;
        }
        else if (get(int(location.x), int(location.y-1)) == color(0, 0, 0))
        {
          dir = UP;
        }
        else
        {
          dir = -1;
        }
      }
    }
    else if (dir == UP)
    {
      location.y--;
      if (get(int(location.x), int(location.y-1)) != color(0, 0, 0))
      {
        if (get(int(location.x+1), int(location.y)) == color(0, 0, 0) && get(int(location.x-1), int(location.y)) == color(0, 0, 0))
        {
          rand = random(0, 2);
          if (rand > 1)
          {
            dir = RIGHT;
          }
          else
          {
            dir = LEFT;
          }
        }
        else if (get(int(location.x+1), int(location.y)) == color(0, 0, 0))
        {
          dir = RIGHT;
        }
        else if (get(int(location.x-1), int(location.y)) == color(0, 0, 0))
        {
          dir = LEFT;
        }
        else
        {
          dir = -1;
        }
      }
    }
    else if (dir == DOWN)
    {
      location.y++;
      if (get(int(location.x), int(location.y+1)) != color(0, 0, 0))
      {
        if (get(int(location.x+1), int(location.y)) == color(0, 0, 0) && get(int(location.x-1), int(location.y)) == color(0, 0, 0))
        {
          rand = random(0, 2);
          if (rand > 1)
          {
            dir = LEFT;
          }
          else
          {
            dir = RIGHT;
          }
        }
        else if (get(int(location.x-1), int(location.y)) == color(0, 0, 0))
        {
          dir = LEFT;
        }
        else if (get(int(location.x+1), int(location.y)) == color(0, 0, 0))
        {
          dir = RIGHT;
        }
        else
        {
          dir = -1;
        }
      }
    }
  }
}

