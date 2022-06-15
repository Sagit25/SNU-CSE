import java.io.*;
import java.nio.charset.StandardCharsets;

public class Subway {
    static Graph subwayMap = new Graph();
    static StringBuilder sb = new StringBuilder();

    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in, "utf-8"));
        String buildInfo = args[0];
        subwayMap = new Graph(buildInfo);

        while (true) {
            try {
                String input = br.readLine();
                if (input.compareTo("QUIT") == 0) {
                    break;
                }
                command(input);
            }
            catch (IOException e) {
                System.out.println("입력이 잘못되었습니다. 오류 : " + e.toString());
            }
        }
        System.out.print(sb);
    }

    private static void command(String input) {
        try {
            String[] subwayInfo = input.split(" ");
            String station1 = subwayInfo[0];
            String station2 = subwayInfo[1];

            sb.append(subwayMap.path(station1, station2));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}