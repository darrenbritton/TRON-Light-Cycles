
public void startgame(GButton source, GEvent event)
{
  menu.pause();
  initAI();
  restart();
  hideGUI();
  clear();
  background(0);
  noFill();
  frameRate(fr);
  time.start();
  pause = false;
  //println("button1 - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void scoreboard(GButton source, GEvent event)
{
  clear();
  scoreboard();
  scoreboardMenu();
  //println("button2 - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void scoreboardmenu(GButton source, GEvent event)
{
  clear();
  menu();
  scoreboardmenubutton.setVisible(false);
  //println("button4 - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void exitgame(GButton source, GEvent event)
{
  exit();
  //println("button4 - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void settings(GButton source, GEvent event)
{
  hideGUI();
  settingsmenu();
  //println("button1 - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void menu(GButton source, GEvent event)
{
  menu();
  //println("menubutton - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void restart(GButton source, GEvent event)
{
  restart();
  //println("restartbutton - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void difficulty(GSlider source, GEvent event)
{
  difficultyValue = difficultySlider.getValueI();
  if (difficultyValue == 1)
  {
    fr = 120;
  }
  else if (difficultyValue == 2)
  {
    fr = 180;
  }
  else if (difficultyValue == 3)
  {
    fr = 240;
  }
  //println("difficultyslider - GSlider event occured " + System.currentTimeMillis()%10000000 );
}

public void numAI(GSlider source, GEvent event)
{
  numAIs = AISlider.getValueI();
  //println("AIslider - GSlider event occured " + System.currentTimeMillis()%10000000 );
}

public void settingsmenu(GButton source, GEvent event)
{
  difficultySlider.setVisible(false);
  AISlider.setVisible(false);
  settingsmenubutton.setVisible(false);
  menu();
  inSettings= false;
  //println("menubutton - GButton event occured " + System.currentTimeMillis()%10000000 );
}

public void handleTextEvents(GTextField name, GEvent event)
{   
  switch(event)
  {
  case CHANGED:
    String temp = name.getText();
    if (temp.length() > 4)
    {
      try
      { 
        Robot robot = new Robot();
        robot.keyPress(KeyEvent.VK_BACK_SPACE);
      }
      catch (AWTException e)
      {
        e.printStackTrace();
      }
    }
    break;  
  case ENTERED:
    Score tempscore = new Score(name.getText(), score);
    //println(tempscore.toString());
    scores.add(tempscore);
    Collections.sort(scores);
    name.setVisible(false);
    clear();
    stroke(0);
    fill(0);
    rect(320, 360, 150, 30);
    fill(tronBlue);
    textSize(100);
    textAlign(CENTER);
    text("WINNER!", width/2, height/2);
    textSize(20);
    text("submitted", width/2, 440);
    won = false;
  }
}

public void createGUI()
{
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.CYAN_SCHEME);
  G4P.setCursor(ARROW);
  if (frame != null)
  {
    int rand = parseInt(random(1, 6));
    if (rand == 1)
      frame.setTitle("TRAWWWWWWWWN!");
    else if (rand == 2)
      frame.setTitle("We're in space :)");
    else if (rand == 3)
      frame.setTitle("TRON: Uprising <= go flupping watch it!");
    else if (rand == 4)
      frame.setTitle("Oh look, there's a sexually attractive line segment ;)");
    else if (rand == 5)
      frame.setTitle("Tron girls are all hot for circles");
    else if (rand == 6)
      frame.setTitle("All hail the mighty Tron overlord, Mark!");
  }
  startButton = new GButton(this, 160, 200, 240, 30);
  startButton.setText("START");
  startButton.addEventHandler(this, "startgame");
  scoreboardButton = new GButton(this, 400, 240, 240, 30);
  scoreboardButton.setText("SCOREBOARD");
  scoreboardButton.addEventHandler(this, "scoreboard");
  exitButton = new GButton(this, 400, 320, 240, 30);
  exitButton.setText("EXIT");
  exitButton.addEventHandler(this, "exitgame");
  settingsbutton = new GButton(this, 160, 280, 240, 30);
  settingsbutton.setText("SETTINGS");
  settingsbutton.addEventHandler(this, "settings");
}

public void settingsmenu()
{
  inSettings = true;
  difficultySlider = new GSlider(this, 520, 100, 190, 60, 10.0);
  difficultySlider.setLimits(1, 1, 3);
  difficultySlider.setNbrTicks(3);
  difficultySlider.setStickToTicks(true);
  difficultySlider.setShowTicks(true);
  difficultySlider.setNumberFormat(G4P.INTEGER, 0);
  difficultySlider.setOpaque(false);
  difficultySlider.addEventHandler(this, "difficulty");
  difficultySlider.setValue(difficultyValue);
  AISlider = new GSlider(this, 520, 220, 190, 60, 10.0);
  AISlider.setLimits(1, 1, 3);
  AISlider.setStickToTicks(true);
  AISlider.setNbrTicks(3);
  AISlider.setShowTicks(true);
  AISlider.setNumberFormat(G4P.INTEGER, 0);
  AISlider.setOpaque(false);
  AISlider.addEventHandler(this, "numAI");
  AISlider.setValue(numAIs);
  settingsmenubutton = new GButton(this, 520, 420, 190, 30);
  settingsmenubutton.setText("MENU");
  settingsmenubutton.addEventHandler(this, "settingsmenu");
  imageMode(CENTER);
  noStroke();
  background(0);
}

public void endgame()
{
  name = new GTextField(this, 320, 360, 150, 30, G4P.SCROLLBARS_NONE);
  name.setOpaque(false);
  name.addEventHandler(this, "handleTextEvents");
  name.setDefaultText("Enter Name Here");
  name.setVisible(false);
  name.setFocus(true);
  //name.setFont(new Font("Dialog", Font.PLAIN, 18));
  if (won)
  {
    name.setVisible(true);
    won = false;
  }
  menubutton = new GButton(this, 70, 420, 240, 30);
  menubutton.setText("MENU");
  menubutton.addEventHandler(this, "menu");
  restartbutton = new GButton(this, 480, 420, 240, 30);
  restartbutton.setText("RESTART");
  restartbutton.addEventHandler(this, "restart");
  endgame = true;
}

public void scoreboardMenu()
{
  scoreboardmenubutton = new GButton(this, (width/2)-60, 350, 120, 30);
  scoreboardmenubutton.setText("MENU");
  scoreboardmenubutton.addEventHandler(this, "scoreboardmenu");
}

public void hideEG()
{
  menubutton.setVisible(false);
  restartbutton.setVisible(false);
}

public void menu()
{
  gameOver = false;
  win.pause();
  loose.pause();
  if (menubutton != null)
    menubutton.setVisible(false);
  if (restartbutton != null)
    restartbutton.setVisible(false);
  if (name != null)
    name.setVisible(false);
  clear();
  menu.loop();
  if (endgame)
  {
    endgame = false;
    hideEG();
  }
  createGUI();
  textSize(100);
  textAlign(CENTER);
  imageMode(CENTER);
  noStroke();
  background(12, 20, 31);
  pause = true;
  inMenu = true;
}

public void restart()
{
  gameOver = false;
  win.pause();
  loose.pause();
  if (menubutton != null)
    menubutton.setVisible(false);
  if (restartbutton != null)
    restartbutton.setVisible(false);
  if (name != null)
    name.setVisible(false);
  clear();
  game.loop();
  clear();
  x = 20;
  y = 20;
  resetAI();
  dir = RIGHT;
  score = 0;
  pause = false;
  time.start();
}


GButton startButton; 
GButton scoreboardButton; 
GButton exitButton; 
GButton settingsbutton;
GButton menubutton;
GButton settingsmenubutton;
GButton scoreboardmenubutton;
GButton restartbutton;
GTextField name;
GToggleGroup settingspage; 
GSlider difficultySlider; 
GSlider AISlider;
