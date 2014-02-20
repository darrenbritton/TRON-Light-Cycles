class Timer 
{
  int start = 0;
  int stop = 0;
  boolean running = false;  


  void start()
  {
    start = millis();
    running = true;
  }

  void stop()
  {
    stop = millis();
    running = false;
  }

  int pull()
  {
    int elapsed;
    if (running)
    {
      elapsed = (millis() - start);
    }
    else
    {
      elapsed = (stop - start);
    }
    return ((elapsed / 1000));
  }
}

