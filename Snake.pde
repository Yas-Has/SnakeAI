class Snake{

  int growthCounter;
  boolean hasTurned;
  ArrayList<Node> body;
  String direction;
  
  
  Snake(int snakeLength){

    growthCounter = 0;
    hasTurned = false;
    body = new ArrayList();
    for(int i = 0; i < snakeLength; i++){
      body.add(new Node(snakeLength - i,0));
    }
    direction = "right";
  }
  Snake(){
    this(6);
  
  }
  
  void draw(){
      fill(0, 255, 0);
      for(int i = 0; i < body.size(); i++){
        drawSquare(body.get(i).x, body.get(i).y);
      }
   
  }
  
  void update(){
  
  }
  
  void move(){
    int dx = 0;
    int dy = 0;
    if(direction == "right"){
      dx = 1;
      
    }
    if(direction == "left"){
      dx = -1;
    }
    if(direction == "up"){
      dy = -1;
    }
    if(direction == "down"){
      dy = 1;
    }
    
    Node newHead = new Node(body.get(0).x + dx, body.get(0).y + dy);
    body.add(0, newHead);
    
    if(growthCounter > 0){
      growthCounter--;
      
    }else{
      body.remove(body.size() - 1);
    }
    
    
  }
  
  boolean contains(int x, int y){
    for(int i = 0; i<this.body.size(); i++){
      if(body.get(i).x == x && body.get(i).y == y){
        return true;
      }
    }
    return false;
    
  
  }
  boolean contains(Node xy){
    return contains(xy.x, xy.y);
  }
  boolean colliding(){
    Node head = body.get(0);
    for(int i = 1; i< this.body.size(); i++){
      if(body.get(i).x == head.x && body.get(i).y == head.y){
        return true;
      
      }
    
    }
    return false;
  
  }
  
  void grow(){
    growthCounter++;
  }
  
  
}
