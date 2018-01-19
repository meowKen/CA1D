class Cell1{

    int x;
    
    Cell1(){
      x=(int)random(0,2);
    }
    
    Cell1(int _X){
      x=_X;
    }
    
};

class CA{
  Cell1[] cells = new Cell1[width/10];
  int generation = 0;
  PrintWriter output;
  int ac = 0;
  
  int[] ruleset = {0,0,0,1,1,1,1,0}; //rule 30
  
  CA(){
    for(int i=0; i<width/10; i++){
      cells[i] = new Cell1();
    }
    output = createWriter("pows.txt");
  }
  
  int[] neighborhood(int _I){
    int[] n = {0,0,0};
    
    int c = 0;
    //for(int i = (_I-1) % cells.length; i<=(_I+1) % cells.length; i++){
    for(int i=-1; i<=1; i++){
      n[c] = cells[ ( _I+i+cells.length ) % cells.length ].x;
      output.println("#"+ac+" | "+( _I+i+cells.length ) % cells.length+" | "+n[c]);
      c++; ac++;
    }
    return n;
  }
  
  void copyCA(Cell1[] _C){
    for(int i=0 ; i<cells.length; i++){
      cells[i] = _C[i];
    }
  }
  
  void generate(){
    Cell1[] next = new Cell1[cells.length];
    for(int i=0 ; i<cells.length; i++){
      int[] v = neighborhood(i);
      int r = (int)(pow(v[0]*2,2)+pow(v[1]*2,1)+ pow(v[2]*2,0));
      println(pow(v[0]*2,2)+" - "+ pow(v[1]*2,1) +" - "+ pow(v[2]*2,0)+" - "+ r);
      next[i] = new Cell1(r);
      //if(voisins[i] == (0,0,0)){}
    }
    copyCA(next);
    generation++;
  }
  
  void show(){
    for(int i=0; i<width/10; i++){
      if(cells[i].x == 0){
        fill(255);
      } else if(cells[i].x == 1){
        fill(0);
      }
      rect(i*10,0,10,10);
    }
  }
};