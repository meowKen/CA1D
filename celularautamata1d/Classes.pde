class Cell1{
  int x;
  
  //construc.
  Cell1(){
    x=(int)random(0,2);
  }
  
  Cell1(int _X){
    x=_X;
  }
    
};

class CA{
  Cell1[] cells = new Cell1[width/10];               //the actual automata
  Cell1[][] tab = new Cell1[width/10][height/10];    //a matrix to stack them ordering by generation (newest on top)
  int generation = 0;
  
  
  //a collection of rules. Feel free to add one, any can work and have != effect as long as the '8 binary digit' is respected
  //int[] ruleset = {0,1,1,1,1,0,0,0}; //rule 30
  //int[] ruleset = {0,0,0,1,0,0,1,1}; //rule 200
  //int[] ruleset = {1,0,0,0,0,0,0,0}; //rule 1
  //int[] ruleset = {0,1,1,0,1,0,0,0}; //rule 22
  int[] ruleset = {0,1,1,0,1,0,0,1}; //rule 150
  //int[] ruleset = {1,0,1,1,0,1,0,0}; //rule 45
  
  //construct.
  CA(){                                  //for each rules to work, the automata needs to start w/ each cells
    for(int i=0; i<width/10; i++){       //w/ the "0" state, only 1 cell with the state "1"
      cells[i] = new Cell1(0);
    }
    cells[(int)random(cells.length)].x = 1;  //this one randomly picks 1 cell to turn it on
    
    for(int i=0; i<width/10; i++){      //init the scrolling matrix
      for(int j=0; j<height/10; j++){
      tab[i][j] = new Cell1(0);
      } 
    }
    
  }
  
  //return a 3 length 1D array containing the neighborhood of the cell w/ index giv. in param.
  //neighborhood of the cell of index i is : ( i-1 , i , i+1 )
  int[] neighborhood(int _I){
    int[] n = {0,0,0};
    int c = 0;
    for(int i=-1; i<=1; i++){
      n[c] = cells[ ( _I+i+cells.length ) % cells.length ].x; // this way of calculong the index
      c++;                                                    // allows to "wrap", neighborhood of i = 0 is (max and 1)
    }
    return n;
  }
  
  //copy the next generation as the curent generation
  void copyCA(Cell1[] _C){
    for(int i=0 ; i<cells.length; i++){
      cells[i] = _C[i];
    }
  }
  
  //shift down every row (prev gen history) and add the last one on top, create this flow down effect
  void shiftAndAdd(Cell1[] _C){
    for(int i=width/10-1; i>=0; i--){
      for(int j=height/10-2; j>=0; j--){
        tab[i][j+1] = tab[i][j];          //the bottom cell = the top cell
      } 
    }
    for(int i=0; i<width/10; i++){
      tab[i][0] = cells[i];
    }
  }
  
  //quiet the main method, generate the new generation depending on the curent gen. cells state
  void generate(){
    Cell1[] next = new Cell1[cells.length];
    for(int i=0 ; i<cells.length; i++){
      int[] v = neighborhood(i);        //get the neighborhood of the cell
      int r = v[0]*4+v[1]*2+ v[2];      //calculate from those 3 binary value the decimal value
      next[i] = new Cell1(ruleset[r]);  //which is used to find the corresponding index of the ruleset
    }
    copyCA(next);                       //calls the other usefull methods
    shiftAndAdd(cells);
    generation++;
  }
  
  //draw everything on screen
  void show(){
    for(int i=0; i<width/10; i++){
      for(int j=0; j<height/10; j++){
        if(tab[i][j].x == 0){
          fill(255);
        } else if(tab[i][j].x == 1){
          fill(0);
        }
        rect(i*10,j*10,10,10);
      }
    }
  }
  
};
