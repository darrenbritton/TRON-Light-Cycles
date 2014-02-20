import java.awt.event.KeyEvent;
import java.awt.AWTException;
import java.awt.Robot;
import g4p_controls.*;
import ddf.minim.*;
import java.util.List;
import java.util.Collections;

color tronBlue = color(91, 175, 203);
color tronOrange = color(223, 116, 12);

PVector startA = new PVector(780, 20);
PVector startB = new PVector(780, 220);
PVector startC = new PVector(780, 400);
PVector a, b, c, d, e, f, g, h, i, j, k, l;

int magicRealismNumber = 30;
int x = 20;
int y = 20;
int numAIs = 1;
int dir = RIGHT;
int fr = 180;
int score = 0;
int smallP = 4;
int largeP = 40;
int logox = 350;
int logoy = 120;
int difficultyValue = 1;

float rand;

boolean pause = false;
boolean inSettings = false;
boolean endgame = false;
boolean won = false;
boolean inMenu = false;
boolean gameOver = false;

PFont font;
PImage imgP;

PrintWriter output;
BufferedReader reader;

Timer time = new Timer();

List<Score> scores = new ArrayList<Score>();
List<String> filedump = new ArrayList<String>();

AI one = null;
AI two = null;
AI three = null;

Minim minim;
AudioPlayer menu;
AudioPlayer game;
AudioPlayer win;
AudioPlayer loose;


void setup()
{
  minim = new Minim(this);
  menu = minim.loadFile("tronTheme.mp3");
  win = minim.loadFile("Win.mp3");
  loose = minim.loadFile("Loose.mp3");
  game = minim.loadFile("tronDerezzed.mp3");
  menu.loop();
  imgP = loadImage("bg.jpg");
  a = new PVector(20, 142);
  b = new PVector(225, 50);
  c = new PVector(575, 50);
  d = new PVector(780, 142);
  e = new PVector(780, 343);
  f = new PVector(575, 435);
  g = new PVector(225, 435);
  h = new PVector(20, 343);
  i = new PVector(399, 207.5+ magicRealismNumber);
  j = new PVector(399, 227.5+ magicRealismNumber);
  k = new PVector(401, 207.5+ magicRealismNumber);
  l = new PVector(401, 227.5+ magicRealismNumber);
  try
  {
    reader = createReader("scoreboard.dat");
    String line;
    try
    { 
      while ( (line = reader.readLine ()) != null)
      {
        filedump.add(line);
      }
    }
    catch(IOException e)
    {
      //e.printStackTrace();
      line = null;
    }
    Score tempscore;
    for (String s : filedump)
    {
      String[] temp = s.split("\\s");
      tempscore = new Score(temp[0], parseInt(temp[1]));
      scores.add(tempscore);
    }
    output = createWriter("scoreboard.dat");
  }
  catch (Exception e)
  {
    //println(e);
    println("creating...");
    File f = new File("scoreboard.dat");
    output = createWriter("scoreboard.dat");
    output.close();
  }
  font = loadFont("TRN-199.vlw");
  textFont(font, 100);
  size(800, 485);
  menu();
}

void draw()
{
  if (inMenu)
  {
    float divisionism = random(smallP, largeP);
    int x = int(random(imgP.width));
    int y = int(random(imgP.height));
    color pix = imgP.get(x, y);
    fill(pix, 128);
    //polygon(int(16*menu.left.get(int((random(1,511))))),x,y,divisionism);
    polygon(int(random(3, 8)), x, y, divisionism);
    fill(tronBlue);
    textSize(100);
    text("TRON", logox, logoy);
    font = loadFont("TRN-20.vlw");
    textSize(25);
    fill(tronOrange);
    text("LIGHT", logox + 120, logoy + 30);
    fill(tronOrange);
    text("CYCLES", logox + 180, logoy + 55);
  }
  if (inSettings)
  {
    float divisionism = random(smallP, largeP);
    int x = int(random(imgP.width));
    int y = int(random(imgP.height));
    color pix = imgP.get(x, y);
    fill(pix, 128);
    polygon(int(random(3, 8)), x, y, divisionism);
    fill(tronOrange);
    font = loadFont("TRN-199.vlw");
    textFont(font, 80);
    text("DIFICULITY", 250, 150);
    text("NUM OF AIS", 250, 250);
    textAlign(CENTER);
    fill(tronBlue);
    textFont(font, 20);
    text("EASY      MEDIUM      HARD", 615, 110);
    text("ONE          TWO       THREE", 620, 230);
  }
  if (pause == false)
  {
    strokeWeight(1);
    if (numAIs == 1)
    {
      DrawOneAI();
    }
    else if (numAIs == 2)
    {
      DrawTwoAI();
    }
    else
    {
      DrawThreeAI();
    }
  }
}
void keyPressed()
{
  if (gameOver == false)
  {
    if (key == ' ')
    {
      pause = !pause;
    } 
    if (key == CODED)
    {
      if (keyCode == LEFT)
      {
        dir = LEFT;
      }
      else if (keyCode == RIGHT)
      {
        dir = RIGHT;
      }
      else if (keyCode == UP)
      {
        dir = UP;
      }
      else if (keyCode == DOWN)
      {
        dir = DOWN;
      }
    }
  }
  if (gameOver == true)
  {
    if (key == 'r')
    {
      restart();
    }
    if (key == 'm')
    {
      menu();
    }
  }
}

void DrawOneAI()
{
  one.draw();
  player();
  if (get(x, y) != color(0, 0, 0) && get(int(one.location.x), int(one.location.y)) == color(0, 0, 0))
  {
    DrawLoose();
  }
  if (get(int(one.location.x), int(one.location.y)) != color(0, 0, 0) && get(x, y) == color(0, 0, 0))
  {
    DrawWin();
  }
}

void DrawTwoAI()
{
  one.draw();
  two.draw();
  player();
  if (get(x, y) != color(0, 0, 0) && (get(int(one.location.x), int(one.location.y)) == color(0, 0, 0) || get(int(two.location.x), int(two.location.y)) == color(0, 0, 0)) )
  {
    DrawLoose();
  }
  if (get(int(one.location.x), int(one.location.y)) != color(0, 0, 0) && get(int(two.location.x), int(two.location.y)) != color(0, 0, 0)  && get(x, y) == color(0, 0, 0) )
  {
    DrawWin();
  }
}

void DrawThreeAI()
{
  one.draw();
  two.draw();
  three.draw();
  player();
  if (get(x, y) != color(0, 0, 0) && (get(int(one.location.x), int(one.location.y)) == color(0, 0, 0) || get(int(two.location.x), int(two.location.y)) == color(0, 0, 0) || get(int(three.location.x), int(three.location.y)) == color(0, 0, 0)))
  {
    DrawLoose();
  }
  if (get(int(one.location.x), int(one.location.y)) != color(0, 0, 0) && get(int(two.location.x), int(two.location.y)) != color(0, 0, 0) && get(int(three.location.x), int(three.location.y)) != color(0, 0, 0) && get(x, y) == color(0, 0, 0))
  {
    DrawWin();
  }
}

void DrawWin()
{
  gameOver = true;
  game.pause();
  win.loop(0);
  won = true;
  time.stop();
  endgame();
  noStroke();
  fill(0, 150);
  rect(0, 0, width, height);
  fill(tronBlue);
  textSize(100);
  textAlign(CENTER);
  text("WINNER!", width/2, height/2);
  textSize(50);
  text("SCORE: ", (width/2) - 100, (height/2) + 100);
  println("Time: " + time.pull() + " Seconds");
  score = fr * numAIs + time.pull();
  text(score, (width/2) + 100, (height/2) + 100);
  stopMovement();
}

void DrawLoose()
{
  gameOver = true;
  game.pause();
  loose.loop(0);
  time.stop();
  noStroke();
  endgame();
  fill(0, 150);
  rect(0, 0, width, height);
  fill(tronOrange);
  textSize(70);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);
  pause = true;
  stopMovement();
}

void initAI()
{
  if (numAIs == 1)
  {
    one = new AI(tronOrange, startA);
  }
  else if (numAIs == 2)
  {
    one = new AI(tronOrange, startA);
    two = new AI(tronOrange, startB);
  }
  else
  {
    one = new AI(tronOrange, startA);
    two = new AI(tronOrange, startB);
    three = new AI(tronOrange, startC);
  }
}

void resetAI()
{
  if (numAIs == 1)
  {
    one.location = new PVector(780, 20);
    one.dir = LEFT;
  }
  else if (numAIs == 2)
  {
    one.location = new PVector(780, 20);
    two.location = new PVector(780, 220);
    one.dir = LEFT;
    two.dir = LEFT;
  }
  else
  {
    one.location = new PVector(780, 20);
    two.location = new PVector(780, 220);
    three.location = new PVector(780, 320);
    one.dir = LEFT;
    two.dir = LEFT;
    three.dir = LEFT;
  }
}

void saveScoreboard()
{
  if (scores.size() < 5)
  {
    for (int i=0; i<scores.size();i++)
    {
      output.println(scores.get(i));
    }
  }
  else
  {
    for (int i=0; i<4;i++)
    {
      output.println(scores.get(i));
    }
  }
}

void hideGUI()
{
  startButton.setVisible(false);
  scoreboardButton.setVisible(false);
  exitButton.setVisible(false);
  settingsbutton.setVisible(false);
  inMenu = false;
}

void player()
{
  stroke(tronBlue);
  point(x, y);
  if (dir == LEFT)
  {
    x--;
  }
  else if (dir == RIGHT)
  {
    x++;
  }
  else if (dir == UP)
  {
    y--;
  }
  else if (dir == DOWN)
  {
    y++;
  }
}

void exit() {
  saveScoreboard();
  output.close();
  super.exit();
}

void stopMovement()
{
  dir = -1;
  if (numAIs == 1)
  {
    one.dir = -1;
  }
  else if (numAIs == 2)
  {
    one.dir = -1;
    two.dir = -1;
  }
  else
  {
    one.dir = -1;
    two.dir = -1;
    three.dir = -1;
  }
}

void scoreboard()
{
  hideGUI();
  stroke(tronBlue);
  strokeWeight(5);
  stretechedOctagonThing(true, 5);
  lightStream(tronOrange, a, i, h, j);
  lightStream(tronBlue, d, k, e, l);
  stretechedOctagonThing(false, 7);
  fill(tronOrange);
  textSize(60);
  textAlign(CENTER);
  text("HIGHSCORES", width/2, 150);
  textAlign(LEFT);
  int y = 50;
  if (scores.size() > 0)
  {
    funkySidewaysWriting((scores.get(0).name + " " + scores.get(0).score), 70, 200, "down", "left");
  }
  if (scores.size() > 1)
  {
    funkySidewaysWriting((scores.get(1).name + " " + scores.get(1).score), 70, 320, "up", "left");
  }
  if (scores.size() > 2)
  {
    funkySidewaysWriting((scores.get(2).name + " " + scores.get(2).score), 730, 200, "down", "right");
  }
  if (scores.size() > 3)
  {
    funkySidewaysWriting((scores.get(3).name + " " + scores.get(3).score), 730, 320, "up", "right");
  }
}

void funkySidewaysWriting(String input, int spacing, int offset, String direction, String side)
{
  fill(40, 40, 40);
  int j=input.length();
  char[] letters = input.toCharArray();
  if (side == "right")
  {
    letters = reverse(letters);
  }
  for (int i=0; i<input.length(); i++)
  {
    textSize(30+(j*1.5));
    if (i > 0)
    {
      if (letters[i-1] == 'I' || letters[i-1] == 'i' || letters[i-1] == '1')
      {
        spacing-=15;
      }
    }
    text(letters[i], spacing, offset);
    if (side == "left")
    { 
      spacing+= 35;
    }
    else 
    {
      spacing-= 35;
    }
    if (direction == "down")
    {
      offset+=6;
    }
    else
    {
      offset-=6;
    }
    j--;
  }
}

