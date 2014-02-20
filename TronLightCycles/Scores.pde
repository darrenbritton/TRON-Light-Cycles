class Score implements Comparable<Score>
{
  String name;
  int score;

  public Score()
  {
    name = "not entered";
    score = 0;
  }

  public Score(String name, int score)
  {
    this.name= name;
    this.score= score;
  }

  public String toString()
  {
    return name + "\t" + score;
  }

  public int compareTo(Score compareScore)
  {

    int comparescore = ((Score) compareScore).score; 

    return comparescore - this.score;
  }
}

