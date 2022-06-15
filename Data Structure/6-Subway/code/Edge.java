public class Edge implements Comparable<Edge> {
    int dest;
    long time;

    public Edge(int dest, long time) {
        this.dest = dest;
        this.time = time;
    }

    @Override
    public int compareTo(Edge edge) {
        if (this.time < edge.time) return -1;
        else return 1;
    }
}
