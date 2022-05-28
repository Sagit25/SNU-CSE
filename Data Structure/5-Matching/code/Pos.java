public class Pos implements Comparable <Pos> {
    public int x, y;

    public Pos(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public int compareTo(Pos pos) {
        if (!(this.x == pos.x) || !(this.y == pos.y)) return 1;
        else return 0;
    }

    @Override
    public String toString() {
        return ("("+y+", "+x+")");
    }
}