class QItem<T>{
  private T item;
  private int priority;
  QItem(T item, int priority){
    this.item = item;
    this.priority = priority;
  }
  
  public T getItem(){
    return this.item;
  }
  
  public int getpriority(){
    return this.priority;
  }
  
  public void setpriority(int priority){
    this.priority = priority;
  }
  
  @Override
  public String toString(){
    return "QItem(" + item.toString() + ", " + priority + ")";
  }

}
