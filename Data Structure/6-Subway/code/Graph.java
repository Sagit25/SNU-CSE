import java.io.*;
import java.util.*;

public class Graph {
    int number;
    int[][] subwayMap;
    HashMap<String, String[]> stationSet;
    HashMap<String, Integer> stationIndex;
    HashMap<String, String> subwayStation;

    public Graph() {
        this.number = 0;
        this.subwayMap = new int[this.number][this.number];
        this.stationIndex = new HashMap<>();
        this.subwayStation = new HashMap<>();
        this.stationSet = new HashMap<>();
    }

    public Graph(String input) throws IOException {
        findNum(input);
        this.stationIndex = new HashMap<>();
        this.subwayStation = new HashMap<>();
        settingHash(input);
        this.stationSet = new HashMap<>();
        this.subwayMap = new int[this.number][this.number];
        buildMap(input);
    }

    public void findNum(String input) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(input),"utf-8"));
            this.number = 0;

            while(true) {
                String line = br.readLine();
                if (line.equals("")) {
                    br.close();
                    break;
                }
                this.number++;
            }
        }
        catch (IOException e) {
            System.out.println("Error! : " + e.toString());
        }
    }

    // setting stationIndex (station scaling to 0~N-1) and subwayStation ((number, name) set)

    public void settingHash(String input) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(input),"utf-8"));

            for (int i = 0; i < this.number; i++) {
                String line = br.readLine();
                String[] subwayInfo = line.split(" ");
                String stationNumber = subwayInfo[0];
                String stationName = subwayInfo[1];
                String stationLine = subwayInfo[2];

                this.stationIndex.put(stationNumber, i);
                this.subwayStation.put(stationNumber, stationName);
            }

            br.close();
        }
        catch (IOException e) {
            System.out.println("Error! : " + e.toString());
        }
    }

    // build graph to use dijkstra

    public int[][] buildMap(String input) throws IOException {
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(input),"utf-8"));

            while(true) {
                String line = br.readLine();
                if (line.equals("")) break;
                String[] subwayInfo = line.split(" ");
                String stationNumber = subwayInfo[0];
                String stationName = subwayInfo[1];
                String stationLine = subwayInfo[2];

                if (!stationSet.containsKey(stationName)) {
                    String[] lines = {stationNumber};
                    stationSet.put(stationName, lines);
                }
                else {
                    String[] prev = stationSet.get(stationName);
                    int length = prev.length;
                    String[] lines = new String[length+1];
                    int num = 0;

                    while (true) {
                        if (num == length) break;
                        lines[num] = prev[num];
                        int number1 = stationIndex.get(prev[num]);
                        int number2 = stationIndex.get(stationNumber);
                        this.subwayMap[number1][number2] = 5;
                        this.subwayMap[number2][number1] = 5;
                        num++;
                    }
                    lines[num] = stationNumber;

                    stationSet.remove(stationName);
                    stationSet.put(stationName, lines);
                }
            }

            String line = "";
            while(true) {
                line = br.readLine();
                if (line == null) break;
                String[] subwayInfo = line.split(" ");
                String station1 = subwayInfo[0];
                String station2 = subwayInfo[1];
                String dist = subwayInfo[2];

                int number1 = stationIndex.get(station1);
                int number2 = stationIndex.get(station2);
                this.subwayMap[number1][number2] = Integer.parseInt(dist);
            }

            br.close();
        }
        catch (IOException e) {
            System.out.println("Error! : " + e.toString());
        }
        return this.subwayMap;
    }

    // print shortest path and time

    public StringBuilder path(String station1, String station2) {
        StringBuilder sb = new StringBuilder();
        MyLinkedList<Integer> subwayPath;
        long result = Integer.MAX_VALUE;
        String[] st1 = stationSet.get(station1);
        String[] st2 = stationSet.get(station2);

        for (String item : st1) {
            for (String element : st2) {
                int number1 = stationIndex.get(item);
                int number2 = stationIndex.get(element);
                Path answer = new Path(this.number, this.subwayMap);
                subwayPath = answer.dijkstra(number1, number2);

                if (result <= answer.time) continue;
                result = answer.time;
                sb = new StringBuilder();
                Node<Integer> prevStation = subwayPath.head.next;
                Node<Integer> nextStation = prevStation.next;

                for (int k = 0; k < subwayPath.size(); k++) {
                    String prev = new String(" ");
                    String next = new String(" ");
                    if (prevStation.item == null) break;

                    int prevNumber = prevStation.item;
                    int nextNumber = nextStation.item;

                    // find key from given value
                    for (String key : stationIndex.keySet()) {
                        Integer value = stationIndex.get(key);
                        if (value == prevNumber) prev = subwayStation.get(key);
                        if (value == nextNumber) next = subwayStation.get(key);
                    }

                    if (!prev.equals(next)) {
                        sb.append(prev);
                        sb.append(" ");
                        prevStation = nextStation;
                    } else {
                        sb.append("[");
                        sb.append(prev);
                        sb.append("] ");
                        prevStation = nextStation.next;
                        k++;
                    }
                    if (prevStation == null) break;
                    if (prevStation.next == null) {
                        prevNumber = prevStation.item;
                        for (String key : stationIndex.keySet()) {
                            Integer value = stationIndex.get(key);
                            if (value == prevNumber) prev = subwayStation.get(key);
                        }
                        sb.append(prev);
                        sb.append(" ");
                        break;
                    }
                    nextStation = prevStation.next;
                }

                String s = new String(sb);
                s = s.trim();
                sb = new StringBuilder(s);
                sb.append("\n");
                sb.append(answer.time);
                sb.append("\n");
            }
        }
        return sb;
    }
}
