class PriorityQueue<T>{
  ArrayList<QItem<T>> list;
  PriorityQueue(){
    list = new ArrayList();
  
  }
  QItem<T> pop(){
    return list.remove(0);
    
  }
  
  void add(QItem qitem){
    //int i = 0;
    //while(i < list.size() && qitem.getpriority() > list.get(i).getpriority()){
    //  i++;
    //}
    //list.add(i, qitem);
    
    if(list.size() == 0){
      list.add(0,qitem);
      return;
    }
    
    int i = 2;
    int j = list.size()/2;
    for(int k = 0; k < ceil(log(list.size())/log(2)); k++){
      if(qitem.getpriority() < list.get(j).getpriority()){
        j-= list.size()/floor(pow(2,i));
      }
      if(qitem.getpriority() > list.get(j).getpriority()){
        j+= list.size()/floor(pow(2,i));
      }
      i++;
    }
    if(qitem.getpriority() < list.get(j).getpriority()){
      j++;
    }
    list.add(j, qitem);
  
  }
  
  QItem<T> peek(){
    return list.get(0);

  }
  
  void updatePriority(QItem<T> qitem, int newPriority){
    list.remove(qitem);
    qitem.setpriority(newPriority);
    this.add(qitem);
  }
  
  boolean isEmpty(){
    return list.size() <  1;
  
  }
  
  @Override
  public String toString(){
    return list.toString();
  }
  
  QItem<T> findItem(T item){
    for(QItem<T> qitem: list){
      if(qitem.getItem().equals(item)){
        return qitem;
      }
    }
    throw new IllegalArgumentException("item not found");
  }

}
