// Class for the Definition of a Point
class Point{
  int x; // X Coordinate
  int y; // Y Coordinate
}

// Class for the Definition of a Named Point
class NamedPoint{
  int Name; // Name of the Point as Integer
  int x; // X Coordinate
  int y; // Y Coordinate
}

// Class for the Definition of a Edge
class Edge{
  // Start and End Point of the Edge
  int p1;
  int p2;
}

// Class for the reservation of a Point
class Sign{
  int number; // Name
  boolean used = false; // Is usd
}

class Web{
  // Data-Space for all the Coins 
  ArrayList<NamedPoint> coins;
  // Data-Space for the Edges
  ArrayList<Edge> edges;
  // Data-Space for Reservation of Names
  ArrayList<Sign> signs = new ArrayList<Sign>();
  
  
  
  // Method to create a Random Coince
  NamedPoint createRandomCoince()
  {
    NamedPoint coince = new NamedPoint(); // Intialize the Coin
      // Define the x Coordinate of the Coin
      coince.x = int(random( 30, (width-30)));
      // Define the y Coordinate of the Coin
      coince.y = int(random(30, (height-30)));
      // Sets the Default for the Name
      int j = 0, jj=0;
      // Sets free Space are founded
      boolean a = false;
      // Iterate about Names to search a free Name
      for(int i = 0; i < signs.size(); i++)
      {
         // If free Space in Signs are founded 
         if (signs.get(i).used == false) { 
           // Save Name of free Space
           jj = signs.get(i).number; 
           // remove old Sign Mark
           signs.remove(i); a = true; break;
         }
         // Sets new upper Name for free Space
         j = max(j, signs.get(i).number+1);
      }
      // If free Space was not founded set Name Mark
      // to Upper free Space
      if(a){j=jj;}
      // Initalise a new Name Entry
      Sign sig = new Sign();
      // Sets the Number and the Status used for the new Name
      sig.number = j;
      sig.used = true;
      // Add the new Name as for reservation
      signs.add(sig);
      coince.Name = j;
      // Add the new Coince
      coins.add(coince);
      // return the Coince for Use in EdgeCreate
      return coince;
  }
  
  // Method to delete a random Coince
  void deleteRandomCoince(){
    // Set place to default 0
    int place = 0;
    // Sets remove are not possible
    boolean an = true;
    // Checks there are any Coins which can been
    // removed
    if(coins.size()>0){
    // Loop until remove was possible
    while(an){
       // define a possible Name which can been removed
       place = int(random(0, signs.size()+1));
       // Search Name to bee removed about all Signs
      for(int i = 0; i < signs.size(); i++)
      {
             
           // Search choosen Name
           if (signs.get(i).number == place){
             // Search a Sign which are used
             if (signs.get(i).used == true){
           // Remove choosen Name
           signs.remove(i);
           // remember that remove was possible
           an = false;
         }}
      }
    }
    // Initalize new Sign Mark
    Sign nsig = new Sign();
    // Set the remove Name for the new Sign
    nsig.number = place;
    // Set this new Sign to unused
    nsig.used = false;
    // Add new Sign Mark to Signs
    signs.add(nsig);
    // delete the choosen Coince
    // coins.remove(place);
    for(int x = 0; x < coins.size(); x++){
      if( coins.get(x).Name == place){coins.remove(x);}
    }
    }
    }
  
  
  // Wrapper Method to deffine a set of new Choinces
  void createRandomCoins(){
    // Initilasation of new Empty Coins Set
    coins = new ArrayList<NamedPoint>();
    // Iteratte about all the needed Coins
    for(int i = 0; i < 6; i++){
      createRandomCoince();
    }
  }
  
  // Method to draw the Coins
  void drawCoins(){
     // Iterrate about all the Coins
     if(coins.size() >= 1 ){
       for(NamedPoint point : coins){
       // Draws the single Choins
       circle(point.x, point.y, 18);
      }
     }
   }
   
   boolean checkDoubledEdges(Edge tedge){
     // Set dounleEdge found to not found
     boolean t = false;
     // test for dummy Edge to not checking
     if(tedge.p1 == -1){
       t = true;
     }
       // If not dummy Edge search for doubled Edges
       else{
        // Iterate about all registered Edges
        for(Edge e : edges){
          // Checks Edge in original Order
         if((e.p1 == tedge.p1) && (e.p2 == tedge.p2)) {
            t = true;
           }
          // Checks Edges in reversed Order 
         if((e.p1 == tedge.p2) && (e.p2 == tedge.p1)){
          t = true;
         }
        }
       }
     // return if found was 
     return t;
    }

    
   
   // Method Overload to definie a new Edge
   void doCreateRandomEdge(){
     // Checks there any Coins which can become an Edge
     int siz = coins.size();
     if(siz > 1){
     Edge myEdge = new Edge(); // Initilise a Edge
     myEdge.p1 = -1; // Sets dummy Edge
     int hi = 0; // Set runout for Edge finding
     int j1 = 0, j2 = 0;
     // Checks a new Edge was not founded and runout is not  
     while(checkDoubledEdges(myEdge) && (hi<10000) ){
       hi++; // Increment runout
      // Set and declare default Values for Edge
      // Cycles to define better Names for the Edges
      while(j1 == j2){
        // Randomly Chose a new Starting Edge
        j1 = int(random(0, signs.size()));
        // try other better Values for the Strting Edge
        while(true){   
          j1 = int(random(0, signs.size()));
          // Checks for Coin is allive
          if(testUsed(j1)){break; }
        }
        // Randomly Chose a new Ending Edge
        j2 = int(random(0, signs.size()));
        // try other better Values for the Strting Edge
        while(true){
          j2 = int(random(0, signs.size()));
          // Checks for Coin is allive
          if(testUsed(j2)){break; }
        }
      }
      // Set new Names to the Edge Object
      myEdge.p1 = j1; //signs.get(j).number; 
      myEdge.p2 = j2; //signs.get(j).number;
      // Set the second Point for the Line
      // Add Edge to the Edges Container
     }
     // Test is Generation aborted by runout
     if(hi>=10000){
       // Message to User about abort
       print("\n Couldn't create a Edge");
     }else
     {
       // Create Edge
       edges.add(myEdge);
     }
     }
   }
   
   // Method to Check is Coin is used marked in Signs
   boolean testUsed(int j){
     boolean a = false; // Set default Value to not used
     // Iterate about all Signs
     for(Sign s: signs){
       // remember is Sign with correct Name is used
       if(s.number == j){a=s.used;}
     }
     // return is Sign with Name is used
     return a;
   }
   
    void doCreateRandomEdge(NamedPoint p){
     // Checks is there any Coins which can have a Edge
     if(coins.size()>1){
      Edge myEdge = new Edge(); // Initilise a Edge
      // Set and declare default Values for Edge
        int j1 = 0, j2 = 0;
        // Cycles to define better Names for the Edges
        while(j1 == j2){
          // Randomly Chose a new Starting Edge
          j1 = p.Name;
          // Randomly Chose a new Ending Edge
          j2 = int(random(0, signs.size()));
          // try other better Values for the Strting Edge
          while(true){   // signs.get(j2).used == false){
            j2 = int(random(0, signs.size()));
            if( testUsed(j2)){break;}
          }
        }
        // Set new Names to the Edge Object
        myEdge.p1 = j1; //signs.get(j).number; 
        myEdge.p2 = j2; //signs.get(j).number;
        // Set the second Point for the Line
        // Add Edge to the Edges Container
        // Only when Edge not duplicated Save Edge
        if(!(checkDoubledEdges(myEdge))){
        edges.add(myEdge);
        }
     }
   }
   
   // Method to count active Points by Signs
   int numberUsedSigns(){
     int z = 0; // Intialize Count to 0
     // Count up for used Point by Sign
     for(Sign s: signs){
       if(s.used == true){z++;}
     }
     return z;
   }
   
   // Method to generate multile Edges for now Coin
   void doCreateRandomEdgen(NamedPoint p){
     // Choose number of multiiple Edges
     int z = int(random(0, numberUsedSigns()));
     // Iterate about all needed new Edges
     for(int i = 0; i < z; i++){doCreateRandomEdge(p);}
   }

  // Creates the Set of Edges for the Web
  void createRandomEdges(){
    edges = new ArrayList<Edge>();
    // Iterrates over the Set of Edges
    for(int i = 0; i < 4; i++){
      doCreateRandomEdge();
    }
  }
  
  // delete a random Edge
  void deleteEdge(){
    if( edges.size() >= 1){ // Test there are any Edges
      // delete the choosen Edge
      edges.remove(int(random(0, edges.size())));
    }
  }
  
  // Method to delete all not Used Edges
  void deleteUnusedEdges(){
    boolean s1, s2; // Declares Found Result
    for(int i = 0; i < edges.size(); i++ ){
      // Check first Point is alive
      s1 = testUsed(edges.get(i).p1);
      // Check second Point is alive
      s2 = testUsed(edges.get(i).p2);
      // Is there any Point of the Edge is not alive remove Edge
      if((!(s1)) || (!(s2))){edges.remove(i);}
    }
  }
  
  // Method for do Brownie Motion for a single Point
  // needs as Parameter the old to move Point
  NamedPoint doBrownoienMotion( NamedPoint oldPoint){
    // Initialice a new Empty Point
    NamedPoint newPoint = new NamedPoint();
    // Default Wrong Variables to calculate new Coordinates
    int x = -1; // x Coordinate
    int y = -1; // y Coordinate
    // While Loop until Coordinate is in correct Space
    // Calculate X Coordinate
    while( (x < 20) || ( x > (width-20))){
      x = oldPoint.x +int(random(-height, height)/50);
    }
    // While Loop until Coordinate is in correct Space
    // Calculate Y Coordinate
    while( (y < 20) || ( y > (height-20)))
    {
      y = oldPoint.y + int(random(-width, width)/50);
    }
    // Sets Variable to newPoint Attributes
    newPoint.x = x; // Set x Attribute
    newPoint.y = y; // Set y Attribute
    newPoint.Name = oldPoint.Name;
    return newPoint; // returns newPoint
  }
   // Method Wrapper that gives BrownienMotion to all Coinces
   // The Coinces are given as Point to the do Method
  void brownienMotion(){
    // Iterate about all Coinces
    for(int i = 0; i < coins.size(); i++){
      // get Coince
      NamedPoint coine = coins.get(i);
      // remove old Coince
      coins.remove(i);
      // Add new Point from Calculation of BrownienMotion
      // about geted old Point
      coins.add(doBrownoienMotion(coine));
    }
  }
  // Spreading Method
  NamedPoint doSprain(NamedPoint oldPoint, Point mouse, float factor ){
    NamedPoint newPoint = new NamedPoint(); // Initalise newPoint
    newPoint.Name = oldPoint.Name;
    int x = -1; // x Coordinate
    int y = -1; // y Coordinate
    // Value to hold the difference between Mouse and oldPoint
    int xdif; // x Difference
    int ydif; // y Difference 
    xdif = oldPoint.x - mouse.x; // Calculate x Difference
    ydif = oldPoint.y - mouse.y; // Calculate y Difference
    // Calculate the Spreading Action
    // Action for x
    x = oldPoint.x + int(factor * xdif*exp(log(1.01)*(-abs(xdif))));
    // Action for y
    y = oldPoint.y + int(factor * ydif*exp(log(1.01)*(-abs(ydif))));
    // Garanty that Values in the Canvss
    x = max(min(x, (width-30)), 30); // X Check
    y = max(min(y, (height-30)), 30); // Y Check
    newPoint.x = x; // Set x Attribute
    newPoint.y = y; // Set y Attribute
    return newPoint; // returns newPoint
  }
  
  // Wrapper Method to do Spreading about all Coins
  void sprain(Point mouse, float factor){
    NamedPoint co;
    // Iterate over the Coins
    for(int i = 0; i < coins.size(); i++){
      // Call doSprain for all single Coinces
      co = doSprain(coins.get(i), mouse, factor );
      coins.remove(i);
      coins.add(co);
    }
  } 

 // Search for NamedPoint in Coins
 NamedPoint searchNamedPoint(int name){
    // Initialize result to empty Point
    NamedPoint result = new NamedPoint();
    // Set Variable for Founding to not Found
    boolean a = true;
    // Iterates about all Points
    for(NamedPoint point : coins){
      // If the Point was found
      if( point.Name == name ){
        // gives founded Point to Result
        result = point;
        // Set Founding to Found
        a = false;
        // break then Looop
        break;
      }
      // Was not Founding gives Point a dummy Attribute
      if(a){ result.x = -555;}
    }
    // Return Resultate
    return result;
  }
  
  // Method to draw Edges
  void drawEdges(){
    // Declare Start and End Point of Edge
    NamedPoint point1, point2;
    // Iterates about the given Edges
    for(Edge myEdge : edges){
      // Search for Startig Point
      point1 = searchNamedPoint(myEdge.p1);
      // Search for Ending Point
      point2 = searchNamedPoint(myEdge.p2);
      // Checks if there not any Point with dummy Attribute
      if((point1.x != -555) && (point2.x != -555)){
        // Draws the Line betwee the Points aka Edges
        line(point1.x, point1.y, point2.x, point2.y);
      
     }
    }
  }
  
}

 // Declare the Working Web
 Web myWeb;
 // Declare the SprainFactor
 float sprainFactor;
 // Declare is saving active
 boolean saving = false;
 
 // Print the Greating Message
 void greating(){
   print("\nWelcome to the Posenenske Web Programm");
   print("\nThis Program draws an Posenenske Web");
   print("\nYou can make some Interaction with the Program");
 }

// Setup the Enviroment
void setup(){
  // Defines the Canvas Size
  size(500,300);
  // Intilaize new Working Web
  myWeb = new Web();
  // Create first Set of Coins
  myWeb.createRandomCoins();
  // Create first Set of Edges
  myWeb.createRandomEdges();
  // Set slow frameRate
  frameRate(2); 
  // do greating
  greating();
  // put menue
  menue();
 }

// the Drawig Cycle Function
void draw(){
  // Clear Canvas
  clear();
  // Set Canvas to whithe
  background(255);
  // Sets fill Color for Coinces to Read
  fill(255,0,0);
  // Sets Countour of Coninces to small
  strokeWeight(2);
  // Draws actual Coinces
  myWeb.drawCoins();
  // Set lineweight for Edges to big
  strokeWeight(5);
  // Draws actual Edges
  myWeb.drawEdges();
  // Do BrownienMotion
  myWeb.brownienMotion();
  // Is saving true save actual Frame for Movie
  if(saving){
    saveFrame("Web-######.png");
  }
}

// Handle mouse clicked Event
void mouseClicked() {
  // Intialize Point for mouse Parameters
  Point mouse = new Point();
  // Store Mouse Parameters
  mouse.x = mouseX; // Store X Coordinate from Mouse
  mouse.y = mouseY; // Store Y Coordinate from Mouse
  // Make Sprain with Mouse Parameters
  myWeb.sprain(mouse, sprainFactor);
  // put Menue
  menue();
}

// Handle Mouse Wheel Event
void mouseWheel(MouseEvent event) {
  // Get Mouse Wheel Value
  float e = event.getCount();
  // Change SprainFactor by Mouse Wheel Value
  sprainFactor = sprainFactor + (e/10);
  // Put new Message about now SprainFactor Value
  println("\n The new SprainFactor is: "+ sprainFactor);
}

// Handle Key Pressed Event
void keyPressed(){
  // Get the pressed key
  char k = key;
  // Working with new Set of Edges
  if(k=='e'){ myWeb.createRandomEdges();}
  // Create a new Coince and put a new Edge
  if(k=='c'){ NamedPoint p = myWeb.createRandomCoince(); myWeb.doCreateRandomEdgen( p);}
  // Delete a Coince and remove now obsolet Edges
  if(k=='d'){ myWeb.deleteRandomCoince(); myWeb.deleteUnusedEdges();}
  // Delete an Random Edge
  if(k == 'f'){ myWeb.deleteEdge();}
  // Create a new Edge
  if(k=='m'){ myWeb.doCreateRandomEdge();}
  // Create a whole new Web
  if(k=='n'){ 
    // Initilze new Web
    myWeb = new Web();
    // Create some Coinces
    myWeb.createRandomCoins();
    // Create some Edges
    myWeb.createRandomEdges();
  }
  // Enamble disable Saving frames to Movie
  // Start Saving
  if(k=='s'){ saving = true; print("\n Movie saving");}
  // End Saving
  if(k=='w'){ saving = false; print("\n Movie saved");}
  // put menue
  menue();
}

// print the Menue
void menue(){
  print("\n Menue:");
  print("\n With e you can create a new Set of Edges");
  print("\n With c you can add one more Coin");
  print("\n With d you can delete one Coin");
  print("\n with m you can add one more Edge"); 
  print("\n With f you can delete a Edge"); 
  print("\n with n you can create a whole new Web");
  print("\n with a Mouse Click you can spreading and");
  print("\n   compress your Coinces");
  print("\n Whith the Mouse Whell you can");
  print("\n    change the Spreading Factor");
  println("\n with s you can save your Movie");
  println("\n and with w you can stop your Recording");
}
