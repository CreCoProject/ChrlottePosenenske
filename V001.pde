
// Class to hold the Coordinates of a Point
class Point{
  int x; // X Coordinate
  int y; // Y Coordinate
}

// Class for a Drawing Instance called Frame
class Frame{ 
  Point[] points = new Point[6]; // The Points which define the Frame
  
  // This Method should construct the whole Frame
  void createFrame() {
    points[0] = new Point(); // Initialize the Starting Point
    // Define Starting Point as left upper Corner
    points[0].x = 0;
    points[0].y = 0;
    // Define the Middle Points in a Loop
    for(int i = 1; i < 5; i++){
      points[i] = createAStep(points[i-1]);
    }
    // Define the last Point
    points[5] = createLastStep(points[4]);
  }
  
  // Method to calculate the last Point
  Point createLastStep(Point oldPoint){
    Point lastPoint = new Point(); // Initialise the last Point
    // Rool a Dice to chose last Direction
    int coin = int(random(0,2));
    // Handle X holding for End Point Calculation
    if(coin == 0){
      lastPoint.x = oldPoint.x; // hold X Coordinate
      lastPoint.y = 100; // Set Y Coordinate to boundary
    }
    // Handle Y holding for End Point Cacluation 
    if(coin == 1){
      lastPoint.y = oldPoint.y; // hold Y Coordinate
      lastPoint.x = 100; // Set X Coordinate to boundary
    }
    return lastPoint; // Return Calculated LastPoint
  }
  
  // Random Function refined for Coordinate Chossing
  int doRandom(int down, int maxValue){
    int coin = -1; // Intialise Coin to default wrong
    // Calculate a Random for Full Range and reject Result when outside desired Scope
    while(coin<down){ coin = int(random(0, maxValue));}
    return coin; // Return new Random Value
  }
  
  // Create Middle Points for Frame
  // needs the last Point in respect to the new Point
  Point createAStep(Point oldPoint ){
    Point newPoint = new Point(); // Initialize newPoint
    // Rool a Dice to chose next Direction for nextPoint
    int con = int(random(0,2));
    // if X Coordinate is Holding Y Coordinate is Calculated
    if(con == 0){
      newPoint.x = oldPoint.x;
      newPoint.y = doRandom(oldPoint.y, 100);
    }
    // if Y Coordinate is Holding X Coordinate is Calulated
    if(con == 1){
      newPoint.y = oldPoint.y;
      newPoint.x = doRandom(oldPoint.x, 100);
    }
    return newPoint; // Return the newPoint
  }
  
  // This Function is in the Drawing Methodic the last Instance
  // Which draws finally the rectangles which build up the Figure
  // of the Frame
  void rectangle(int x1, int y1, int x2, int y2, int wid, int c1, int c2, int c3 ){
    noStroke(); // This Function relaise that there are no sorounding Lines
    fill(c1, c2, c3); // This Function sets the Color for the Rectangle
    // Check is Horizontal or Vertical Rectangle needed#
    // And draw the needed Rectangle with the correct wide
    if(x1==x2){
      rect(x1, y1, wid, y2-y1); // Draws the vertical Rectangle
    }
    if(y1==y2){
      rect(x1, y1, x2-x1, wid); // Draws the horizontal Rectangle
    }
      
  }
  
  // This Function will laeter Draw the Frame on the Canvas
  void painting(int xStart, int yStart, int wide, int heigh, boolean dir ){
    int wid = int(random(widlo, widhi)); // Defines the Wide of the Shape from the Frame
    // Defines the Color Parameter for the Shape of the Frame
    int c1 = int(random(0,2))*255; // Deffines there any readly
    int c2 = int(random(0,2))*255; // Deffines there any greenly
    int c3 = int(random(0,2))*255; // Deffines there any bluely
    for(int i = 0; i < (6-1); i++){ // It cycles over all Points in the Frame
      // This then draws the Lines between the Points of the Frame
      // The Dir Parameter sets the Direction in which the Frame is Painted
      // The Heigh/100 and wide/100 Terms sets the Dimension of the Lines like the Size of the drawing Frame
      if(dir){
        // This should draw the horizontal Direction
        rectangle(points[i].x* (wide/100)+ xStart, points[i].y*(heigh/100)+ yStart, points[i+1].x*(wide/100) + xStart, points[i+1].y*(heigh/100)+yStart, wid, c1, c2, c3);
      }
      if(!dir){
        // This should draw the vertical Direction.
        rectangle(points[i].y* (wide/100)+ xStart, points[i].x*(heigh/100)+ yStart, points[i+1].y*(wide/100) + xStart, points[i+1].x*(heigh/100)+yStart, wid, c1, c2, c3);
      }
      
    }
  }
}

// This is the Class which holds all the single Frames
class Frames{
  // The Data Space where the frames are holded
  Frame[] frames = new Frame[4];
  
  // Method to Create all the Frames are needed
  void setingFrames(){
    // Iterrate about all needed Frames
    for(int i=0; i<4; i++){
      frames[i] = new Frame(); // Intilize the Frame
      frames[i].createFrame(); // Create the Frame
    }
  }
  
  // Method to Draw multiple Shapes from the Frames
  // And spread them with different Size about the Canvas
  void drawFrames(){
    // Data Space for the Current Frame
    Frame myFrame;
    // Paramters for the placing of the Shape
    int x; // Define the left Corner
    int y; // Define the upper Corner
    int xsize; // Define the Width of the Shape
    int ysize; // Defines the Height of the Shape
    boolean dir = false; // Defines the drawig Direction of the Shape
    int pdir; // Helper Varible for the Direction Parameter
    clear();
    background(255);
    // Itterate about the needed Shapes
    for(int i = 0; i < shapesn; i++)
    {
      // Select a Frame for the Shape
      myFrame = frames[int(random(0,3))];
      x = int(random(0, width)); // Random Set the X Corner
      y = int(random(0, height)); // Random Set the Y Corner
      xsize = int(random(0, width-x)); // Random Set correct width
      ysize = int(random(0, height-y)); // Random Set corret height 
      pdir = int(random(0,2)); // Pre Set the Direction
      // Create Boolean Direction from Int Direction
      if(pdir == 0){ dir = true;} 
      if(pdir == 1){ dir = false;}
      // Finally Draw the Shape
      myFrame.painting(x, y, xsize, ysize, dir);
    }
  }
}

// Data Space for the Frames Container holding all Frames
Frames myFrames; 
// Parameters for the smallest and bigest Stroke Line
int widlo = 1; // smallest Stroke
int widhi = 5; // bigest Stroke
// Parameters for Amount of Shapes in Drawing
int shapesn = 3; 

// Seting the Canvas
void setup(){
  // Defines the Size of the Canva
  size(300, 500);
  // Set the Background Color
  background(255);
  // Define the Frames Model
  myFrames = new Frames();
  // Create the Frames
  myFrames.setingFrames();
  // Draws finally the Frames
  myFrames.drawFrames();
  printGreating();
  printMenue();
}

void printGreating(){
  print("\n Welcome to the Posenenske Repeated Frames drawer");
  print("\n Just you see a first Example of the Drawing");
  print("\n In the Menue you see the Options you have");
  print("\n The Drawing is Created from random choosen");
  print("\n And repeated Drawing Frames"); 
}

// Do nothing interactive or animated
void draw(){
}

// Handler for KeyPressed Event
void keyPressed(){
  char in = key; // Saving pressed Key
   // Saves Image to "Output.png"
  if(in == 's'){save("Output.png");}
  // Calculate a new Set of Frames
  if(in == 'f'){myFrames.setingFrames();}
  // Draws a now Random Painting with given Frames
  if(in == 'd'){myFrames.drawFrames();}
  
  // Access to the main Painting Parameters
  // Sets the biggnes of a Line
  // Makes the biggest Line bigger
  if((in == 'w')&&(widhi<width)){
    // Equption to make bigger
    widhi = widhi + max(1, widhi/6);
    // prints the new biggness
    print("\n The new biggest line is "+widhi+"\n");
  } 
  // Makes the biggest line smaler
  if(in == 'x'){
      // Equption to make smaller
      widhi = widhi - max(1, widhi/6);
      // Checks is smallest line then avoid
      if(widhi<1){ widhi = 1;}
      // prints the new biggess
      print("\n The new biggest line is "+widhi+"\n");
  }
   // Makes the smallst Line bigger 
   if((in == 'e')&&(widlo<width)){
     // Equption to make bigger
     widlo = widlo + max(1, widlo/6);
     // prints the new smallest
    print("\n The new smallst line is "+widlo+"\n");
  } 
  // Makes the smallest Line smaller
  if(in == 'c'){
      // Equption to make smaller
      widlo = widlo - max(1, widlo/6);
      // Checks is smallest
      if(widlo<1){ widlo = 1;}
      // prints the new smallest
      print("\n The new smallst line is "+widlo+"\n");
  } 
  // Sets the number of Shapes in Painting
  // Increase the number of Shapes
   if((in == 'r')&&(shapesn < 100)){
    shapesn++; // increase shapes amount
    // print new shapes amount
    print("\n You have just " + shapesn + " Shapes \n");
  }
  // reduce the number of Shapes 
  if((in == 'v')&&(shapesn>1)){
    shapesn--; // reduce
    // print new shapes amount
    print("\n You have just " + shapesn + " Shapes \n");
  } 
  printMenue();
}

void printMenue(){
  print("\n Menue:");
  print("\n Press f to create a new Set of Frames");
  print("\n Press d to create a new Drawing from given Frames");
  print("\n Press s to save current Drawing to Output.png");
  print("\n Press w to increease x to decrease biggnes of Lines");
  print("\n Press e to increease c to decrease smallnes of Lines");
  print("\n Press r to increease v to decrease numbers of Shapes in Drawing");
}
