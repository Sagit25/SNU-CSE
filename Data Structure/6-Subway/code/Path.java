import java.util.*;

public class Path {
    int n;
    long time;
    int[][] G;
    MyLinkedList<Integer> answer;

    public Path(int n, int[][] G){
        this.n = n;
        this.time = 0;
        this.G = G;
        this.answer = new MyLinkedList();
    }

    private final int INF = Integer.MAX_VALUE;

    // Shortest Path Algorithm: Dijkstra Algorithm
    // modified from lecture note's logic

    public MyLinkedList <Integer> dijkstra(int start, int end) {
        PriorityQueue<Edge> pq = new PriorityQueue<>();
        boolean[] check = new boolean[n];
        long[] dist = new long[n];
        int[] from = new int[n];
        MyLinkedList<Integer> path = new MyLinkedList<>();
        Stack<Integer> s = new Stack<>();

        // Find short distance (modified from lecture note's dijkstra logic)

        for (int i = 0; i < n; i++) {
            dist[i] = INF;
            check[i] = false;
        }
        dist[start] = 0;
        pq.add(new Edge(start, 0));

        while (!pq.isEmpty()) {
            Edge now = pq.poll();
            if (check[now.dest]) continue;
            check[now.dest] = true;
            for (int next = 0; next < n; next++) {
                if (G[now.dest][next] <= 0) continue;
                long nowDist = (long) G[now.dest][next];
                if (dist[next] >= dist[now.dest] + nowDist) {
                    pq.add(new Edge(next, dist[now.dest] + nowDist));
                    dist[next] = dist[now.dest] + nowDist;
                    from[next] = now.dest;
                }
            }
        }

        this.time = dist[end];

        // Find path of distance which calculate by dijkstra algorithm

        s.add(end);
        int before = from[end];

        while(true) {
            s.add(before);
            if (before == start) break;
            before = from[before];
        }
        while(!s.isEmpty()) {
            int tmp = s.pop();
            this.answer.add(tmp);
        }

        return this.answer;
    }
}
