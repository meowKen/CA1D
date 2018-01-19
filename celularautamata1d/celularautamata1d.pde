CA _G;

void setup(){
  size(600,600);
  _G = new CA();
}

void draw(){
  _G.generate();
  _G.show();
}