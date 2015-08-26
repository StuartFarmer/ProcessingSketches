int[] randomCounts;

void setup() {
  size(640, 240);
  randomCounts = new int[20];
}

void draw() {
  background(255);
  randomCounts[int(random(randomCounts.length))]++;
  stroke(0);
  fill(175);
  for (int i = 0; i < randomCounts.length; i++) {
    rect(i * (width/randomCounts.length), height-randomCounts[i], (width/randomCounts.length)-1, randomCounts[i]); 
  }
}