import java.util.HashMap;


class Node {
  int x;
  int y;

  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof Node)) {
      return false;
    }

    Node other = (Node) o;

    return x == other.x && y == other.y;
  }

  @Override
  public int hashCode() {
    return (int) (pow(2, x) * pow(3, y));
  }
}
