import java.io.*;
import java.util.*;

public class SortingTest {
	public static void main(String args[]) {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));

		try {
			boolean isRandom = false;	// 입력받은 배열이 난수인가 아닌가?
			int[] value;	// 입력 받을 숫자들의 배열
			String nums = br.readLine();	// 첫 줄을 입력 받음
			if (nums.charAt(0) == 'r') {
				// 난수일 경우
				isRandom = true;	// 난수임을 표시

				String[] nums_arg = nums.split(" ");

				int numsize = Integer.parseInt(nums_arg[1]);	// 총 갯수
				int rminimum = Integer.parseInt(nums_arg[2]);	// 최소값
				int rmaximum = Integer.parseInt(nums_arg[3]);	// 최대값

				Random rand = new Random();	// 난수 인스턴스를 생성한다.

				value = new int[numsize];	// 배열을 생성한다.
				for (int i = 0; i < value.length; i++)	// 각각의 배열에 난수를 생성하여 대입
					value[i] = rand.nextInt(rmaximum - rminimum + 1) + rminimum;
			}
			else {
				// 난수가 아닐 경우
				int numsize = Integer.parseInt(nums);

				value = new int[numsize];	// 배열을 생성한다.
				for (int i = 0; i < value.length; i++)	// 한줄씩 입력받아 배열원소로 대입
					value[i] = Integer.parseInt(br.readLine());
			}

			// 숫자 입력을 다 받았으므로 정렬 방법을 받아 그에 맞는 정렬을 수행한다.
			while (true) {
				int[] newvalue = (int[])value.clone();	// 원래 값의 보호를 위해 복사본을 생성한다.

				String command = br.readLine();

				long t = System.currentTimeMillis();
				switch (command.charAt(0)) {
					case 'B':	// Bubble Sort
						newvalue = DoBubbleSort(newvalue);
						break;
					case 'I':	// Insertion Sort
						newvalue = DoInsertionSort(newvalue);
						break;
					case 'H':	// Heap Sort
						newvalue = DoHeapSort(newvalue);
						break;
					case 'M':	// Merge Sort
						newvalue = DoMergeSort(newvalue);
						break;
					case 'Q':	// Quick Sort
						newvalue = DoQuickSort(newvalue);
						break;
					case 'R':	// Radix Sort
						newvalue = DoRadixSort(newvalue);
						break;
					case 'X':
						return;	// 프로그램을 종료한다.
					default:
						throw new IOException("잘못된 정렬 방법을 입력했습니다.");
				}
				if (isRandom) {
					// 난수일 경우 수행시간을 출력한다.
					System.out.println((System.currentTimeMillis() - t) + " ms");
				}
				else {
					// 난수가 아닐 경우 정렬된 결과값을 출력한다.
					StringBuilder sorted = new StringBuilder();
					for (int i = 0; i < newvalue.length; i++) {
						sorted.append(newvalue[i]);
						sorted.append("\n");
						// System.out.println(newvalue[i]);
					}
					System.out.print(sorted);
				}

			}
		}
		catch (IOException e) {
			System.out.println("입력이 잘못되었습니다. 오류 : " + e.toString());
		}
	}

	// Many Sorting Algorithms are Modified from Lecture Note

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoBubbleSort(int[] value) {
		// TODO : Bubble Sort 를 구현하라.
		// value는 정렬안된 숫자들의 배열이며 value.length 는 배열의 크기가 된다.
		// 결과로 정렬된 배열은 리턴해 주어야 하며, 두가지 방법이 있으므로 잘 생각해서 사용할것.
		// 주어진 value 배열에서 안의 값만을 바꾸고 value를 다시 리턴하거나
		// 같은 크기의 새로운 배열을 만들어 그 배열을 리턴할 수도 있다.
		for (int i = value.length-1; i >= 0; i--) {
			for (int j = 0; j < i; j++) {
				if (value[j] > value[j+1]) {
					int tmp = value[j];
					value[j] = value[j+1];
					value[j+1] = tmp;
				}
			}
		}
		return (value);
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoInsertionSort(int[] value) {
		// TODO : Insertion Sort 를 구현하라.
		for (int i = 1; i < value.length; i++) {
			int insItem = value[i];
			int flag = 0;
			for (int j = i-1; j >= 0; j--) {
				if (insItem < value[j]) {
					value[j+1] = value[j];
				}
				else {
					value[j+1] = insItem;
					flag = 1;
					break;
				}
			}
			if (flag == 0) {
				value[0] = insItem;
			}
		}
		return (value);
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoHeapSort(int[] value) {
		// TODO : Heap Sort 를 구현하라.
		for (int i = (value.length - 1) / 2; i >= 0; i--) {
			percolateDown(value, i, value.length);
		}
		for (int i = value.length - 1; i > 0; i--) {
			int tmp = value[0];
			value[0] = value[i];
			value[i] = tmp;
			percolateDown(value, 0, i);
		}
		return (value);
	}

	private static void percolateDown(int[] value, int node, int n) {
		int lChild = 2*node, rChild = 2*node+1;
		if (lChild < n) {
			if ((rChild < n) && (value[lChild] < value[rChild])) {
				if (value[node] < value[rChild]) {
					int tmp = value[node];
					value[node] = value[rChild];
					value[rChild] = tmp;
					percolateDown(value, rChild, n);
				}
			}
			else if (value[node] < value[lChild]) {
				int tmp = value[node];
				value[node] = value[lChild];
				value[lChild] = tmp;
				percolateDown(value, lChild, n);
			}
		}
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoMergeSort(int[] value) {
		// TODO : Merge Sort 를 구현하라.
		if (value.length == 1) return value;
		int[] v1 = new int[value.length/2];
		int[] v2 = new int[(value.length+1)/2];
		for (int i = 0; i < value.length/2; i++) v1[i] = value[i];
		for (int i = 0; i < (value.length+1)/2; i++) v2[i] = value[i+value.length/2];
		v1 = DoMergeSort(v1);
		v2 = DoMergeSort(v2);
		value = merge(v1, v2);
		return (value);
	}

	private static int[] merge(int[] v1, int[] v2) {
		int[] mergeValue = new int[v1.length + v2.length];
		int idxV1 = 0, idxV2 = 0;
		for (int i = 0; i < v1.length + v2.length; i++) {
			if (idxV2 >= v2.length || idxV1 >= v1.length) {
				if (idxV2 >= v2.length) {
					mergeValue[i] = v1[idxV1];
					idxV1++;
				}
				else {
					mergeValue[i] = v2[idxV2];
					idxV2++;
				}
			}
			else {
				if (v2[idxV2] >= v1[idxV1]) {
					mergeValue[i] = v1[idxV1];
					idxV1++;
				}
				else {
					mergeValue[i] = v2[idxV2];
					idxV2++;
				}
			}
		}
		return mergeValue;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoQuickSort(int[] value) {
		// TODO : Quick Sort 를 구현하라.
		value = QuickSort(value, 0, value.length);
		return (value);
	}

	private static int[] QuickSort(int[] value, int start, int end) {
		if (start == end) return value;
		int mid = partition(value, start, end);
		QuickSort(value, start, mid);
		QuickSort(value, mid+1, end);
		return (value);
	}

	private static int partition(int[] value, int start, int end) {
		int pivot = value[start];
		int cut = start;
		for (int i = start+1; i < end; i++) {
			if(value[i] < pivot) {
				cut++;
				int tmp = value[i];
				value[i] = value[cut];
				value[cut] = tmp;
			}
		}
		value[start] = value[cut];
		value[cut] = pivot;
		return cut;
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////
	private static int[] DoRadixSort(int[] value) {
		// TODO : Radix Sort 를 구현하라.
		int[] bucket = new int[value.length];
		int[] counts = new int[19];
		int sortCnt = 0;
		for (int i = 0; i < value.length; i++) {
			int nowNum = 0, nowCnt = 0;
			if (value[i] >= 0) nowNum = value[i];
			else nowNum = -value[i];
			while (nowNum > 0) {
				nowNum /= 10;
				nowCnt++;
			}
			if (sortCnt < nowCnt) sortCnt = nowCnt;
		}
		int digit = 1;
		for (int i = 1; i <= sortCnt; i++) {
			for (int j = 0; j <= 18; j++) {
				counts[j] = 0;
			}
			for (int j = 0; j < value.length; j++) {
				int num = (value[j]/digit)%10+9;
				counts[num]++;
			}
			for(int j = 1; j < 19; j++) {
				counts[j] += counts[j-1];
			}
			for (int j = value.length - 1; j >= 0; j--) {
				int num = (value[j]/digit)%10+9;
				bucket[--counts[num]] = value[j];
			}
			int[] tmp = value;
			value = bucket;
			bucket = tmp;
			digit *= 10;
		}
		return (value);
	}
}
