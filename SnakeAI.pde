final int BLOCK_SIZE = 10;
int speed = 1;
Snake snake;
Node apple;
ArrayList<Node> snakePath;

void setup(){
  size(1000,1000);
  
  drawSquare(10, 10);
  drawSquare(11, 10);
  snake = new Snake();
  spawnApple();
  snakePath = getPath(apple);
  
}

void spawnApple(){
  do{
    apple = new Node(int(random(0,width/BLOCK_SIZE)),int(random(0, height/BLOCK_SIZE))); 
  }while(snake.contains(apple));
}

void draw(){
  background(0);
  snake.draw();
  fill(255,0,0);
  drawSquare(apple.x, apple.y);
  if(snake.contains(apple)){
    spawnApple();
    snake.grow();
    snakePath = getPath(apple);
  }
  if(snake.colliding()){
    println("snake collided");
    snake = new Snake();
    spawnApple();
  
  }
  Node head = snake.body.get(0);
  if(head.x < 0 || head.x >= width/BLOCK_SIZE){
    snake = new Snake();
    spawnApple();
  
  }
  if(head.y < 0 || head.y >= height/BLOCK_SIZE){
    snake = new Snake();
    spawnApple();
  
  }
  if(frameCount % speed == 0){
    
    if(snakePath.size() > 0){
      //Node head2 = snake.body.get(0);
      Node nextNode = snakePath.get(0);
      if(head.x+1 == nextNode.x){
        snake.direction = "right";
      }
      if(head.x-1 == nextNode.x){
        snake.direction = "left";
      }
      if(head.y+1 == nextNode.y){
        snake.direction = "down";
      }
      if(head.y-1 == nextNode.y){
        snake.direction = "up";
      }
      snakePath.remove(0);
      //snakePath = getPath(apple);
    }
    snake.move();
    snake.hasTurned = false;
  }
  
}
int distNode(Node a, Node b){
  return abs(a.x - b.x) + abs(a.y - b.y);
}

void drawSquare(int x, int y){
  rect(x*BLOCK_SIZE, y*BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE);
}

ArrayList<Node> getAdNodes(Node node, int currentPathDist){
  ArrayList<Node> adNodes = new ArrayList();
  Node[] possible = new Node[]{new Node(node.x, node.y + 1), new Node(node.x + 1, node.y), new Node(node.x, node.y - 1), new Node(node.x - 1, node.y)};
  
  for(Node p: possible){
    if(p.x >= 0 && p.x<width/BLOCK_SIZE && p.y >= 0 && p.y < height/BLOCK_SIZE ){
      if(!snake.contains(p) || snake.body.size() - snake.body.indexOf(p) <= currentPathDist){
        adNodes.add(p);
      }
    }
  } 
  return adNodes;
}

ArrayList<Node> getPath(Node destination){
  Node head = snake.body.get(0);
  PriorityQueue<Node> pq = new PriorityQueue();
  pq.add(new QItem<Node>(head, 0));
  Node currentNode = head;
  HashMap<Node, Node> previousNodes = new HashMap();
  ArrayList<Node> visited = new ArrayList();
  while(!currentNode.equals(destination)){
    QItem<Node> qitem = pq.pop();
    currentNode = qitem.getItem();
    int currentDist = qitem.getpriority();
    for(Node node: getAdNodes(currentNode, currentDist - distNode(currentNode, destination))){
      if(!visited.contains(node)){
        if(previousNodes.containsKey(node)){
          QItem<Node> adj = pq.findItem(node);
          if(adj.getpriority() > currentDist + 1 + distNode(node, destination) - distNode(currentNode, destination)){
            pq.updatePriority(adj, currentDist + 1 + distNode(node, destination) - distNode(currentNode, destination));
            previousNodes.put(node, currentNode);
          }
        }else{
          previousNodes.put(node, currentNode);
          pq.add(new QItem<Node>(node, currentDist + 1 + distNode(node, destination) - distNode(currentNode, destination)));
        }
      }
    }
    visited.add(currentNode);
  }
  
  
  currentNode = destination;
  ArrayList<Node> path = new ArrayList();
  while(!currentNode.equals(head)){
    path.add(0, currentNode);
    currentNode = previousNodes.get(currentNode);
  }
  
  return path;
}
