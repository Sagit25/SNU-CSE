import java.io.*;
import java.util.Iterator;

public class Matching {
	static HashTable <StringCmp, Pos> hashTable = new HashTable <> ();
	final static int k = 6;

	public static void main(String args[]) {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

		while (true) {
			try {
				String input = br.readLine();
				if (input.compareTo("QUIT") == 0)
					break;

				command(input);
			}
			catch (IOException e) {
				System.out.println("입력이 잘못되었습니다. 오류 : " + e.toString());
			}
		}
	}

	private static void command(String input) {
		if (input.isEmpty()) return;
		char op = input.charAt(0);
		if (op == '<') { // Input data
			hashTable = new HashTable <> ();
			inputData(input.substring(2));
		}
		else if (op == '@') { // Print save data
			int num = Integer.parseInt(input.substring(2));
			printData(num);
		}
		else if (op == '?') { // Search pattern
			searchPattern(input.substring(2));
		}
		else {
			System.out.println("Wrong Input!");
		}
	}

	private static void inputData(String path) {
		try {
			BufferedReader reader = new BufferedReader(new FileReader(path));
			int y = 1;
			String line = reader.readLine();
			while (line != null) {
				for (int i = 0; i < line.length()-k+1; i++) {
					String str = line.substring(i, i+k);
					hashTable.insert(new StringCmp(str), new Pos(i+1, y));
				}
				y++;
				line = reader.readLine();
			}
			reader.close();
		}
		catch (IOException e) { // File not found error
			e.printStackTrace();
		}
	}

	private static void printData(int num) {
		StringBuilder sb = new StringBuilder();
		if (hashTable.table[num] == null) {
			sb.append("EMPTY\n");
		}
		else {
			AVLTree tree = hashTable.table[num];
			if (tree.root == null) {
				sb.append("EMPTY\n");
			}
			String tmp = printTree(tree.root, new StringBuilder());
			sb.append(tmp.substring(0, tmp.length()-1));
			sb.append("\n");
		}
		System.out.println(sb.substring(0, sb.length()-1));
	}

	private static String printTree(AVLNode now, StringBuilder str) {
		if (now == AVLTree.NIL) {
			return str.toString();
		}
		str.append(now.node);
		str.append(" ");
		if (now.leftChild != null) {
			printTree(now.leftChild, str);
		}
		if (now.rightChild != null) {
			printTree(now.rightChild, str);
		}
		return str.toString();
	}

	private static void searchPattern (String input) {
		StringBuilder sb = new StringBuilder();
		if (input.length() < k) {
			sb.append("Wrong Input Length!");
			System.out.println(sb);
			return;
		}
		MyLinkedList <Pos> fst = hashTable.search(new StringCmp(input.substring(0, k)));
		boolean flag = false;
		if (fst == null) {
			sb.append("(0, 0)\n");
			flag = true;
		}
		if (!flag) {
			boolean add = false;
			Node <Pos> iterator = fst.head;
			while (iterator.next != null) {
				iterator = iterator.next;
				boolean chk = true;
				for (int i = 0; i <= input.length()-k; i += k) {
					MyLinkedList<Pos> snd = hashTable.search(new StringCmp(input.substring(i, i + k)));
					if (snd == null) {
						chk = false;
						break;
					}
					boolean having = false;
					Node <Pos> cmp = snd.head;
					while (cmp.next != null) {
						cmp = cmp.next;
						Pos pos = new Pos(iterator.item.x+i, iterator.item.y);
						if (cmp.item.compareTo(pos) == 0) {
							having = true;
							break;
						}
					}
					if (having == false) {
						chk = false;
						break;
					}
					if (i+k > input.length()-k && i != input.length()-k) {
						i = input.length() - 2 * k;
					}
				}
				if (chk) {
					sb.append(iterator.item.toString());
					sb.append(" ");
					add = true;
				}
			}
			if (!add) {
				sb.append("(0, 0)\n");
			}
		}
		System.out.println(sb.substring(0, sb.length()-1));
	}

	private static class StringCmp implements Comparable <StringCmp> {
		String key;

		public StringCmp(String key) {
			this.key = key;
		}

		@Override
		public int compareTo(StringCmp stringKey) {
			if (stringKey != null) {
				return this.key.compareTo(stringKey.key);
			}
			return 1;
		}

		@Override
		public String toString() {
			return this.key;
		}

		@Override
		public int hashCode() {
			int hash = 0;
			for (int i = 0; i < this.key.length(); i++) {
				hash += this.key.charAt(i);
			}
			return hash % 100;
		}
	}
}