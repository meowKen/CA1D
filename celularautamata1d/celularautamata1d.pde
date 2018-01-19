CA _G;

void setup(){
  size(1600,800);
  _G = new CA();
}

void draw(){
  _G.generate();  
  _G.show();
}