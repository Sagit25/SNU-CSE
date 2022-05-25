import java.io.*;
import java.util.Stack;

public class CalculatorTest {
	public static void main(String[] args) {
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		while (true) {
			try {
				String input = br.readLine();
				if (input.compareTo("q") == 0) break;
				command(input);
			}
			catch (Exception e) {
				System.out.println("ERROR");
			}
		}
	}

	private static void command(String input) throws Exception{
		String postfix = makePostfix(input);
		postfix = postfix.trim();
		long answer = evaluate(postfix);
		System.out.println(postfix);
		System.out.println(answer);
	}

	// 연산자라면 우선순위를, 연산자가 아니라면 -1을 돌려주는 메소드
	public static int priority(Character ope) {
		switch(ope) {
			case '^': return 4;
			case '~': return 3;
			case '*': return 2;
			case '/': return 2;
			case '%': return 2;
			case '+': return 1;
			case '-': return 1;
		}
		return -1;
	}

	// infix 형태로 입력된 수식을 postfix 형태로 변경하는 메소드
	private static String makePostfix(String input) throws Exception{
		StringBuilder postfix = new StringBuilder();
		int number = 0;

		// 숫자 사이에 공백이 있는 에러 체크
		for (int i = 0; i < input.length(); i++) {
			char x = input.charAt(i);
			if (number != 2 && '0' <= x && x <= '9') number = 1;
			else if (number != 0 && (x == ' ' || x == '\t')) number = 2;
			else if (number == 2 && '0' <= x && x <= '9') throw new Exception("Invalid Number");
			else number = 0;
		}

		// input 문자열의 공백 제거
		input = input.replaceAll(" ", "");

		// 유효한 괄호인지 확인하고 아니라면 에러 발생
		// 괄호의 짝이 맞아야 하고, 숫자 뒤에 여는 괄호, 문자 뒤에 닫는 괄호가 올 수 없음
		int bracket = 0;
		char x = input.charAt(0);
		for (int i = 0; i < input.length(); i++) {
			char y = x;
			x = input.charAt(i);
			if (x == '(') {
				if ('0' <= y && y <= '9') throw new Exception("ERROR");
				bracket++;
			}
			if (x == ')') {
				if (priority(y) != -1) throw new Exception("ERROR");
				bracket--;
			}
			if (bracket < 0) throw new Exception("ERROR");
		}
		if (bracket != 0) throw new Exception("ERROR");

		// input 문자열을 postfix 형태로 변환
		String num = "";
		Stack <Character> opeStack = new Stack<>();
		boolean unary = true;
		for (int i = 0; i < input.length(); i++) {
			x = input.charAt(i);

			// x가 숫자라면, num에 입력
			if ('0' <= x && x <= '9') {
				num += x;
				unary = false;
			}

			// x가 연산자라면, num을 초기화 하고 postfix에 저장, 연산자는 Stack에 입력
			else if (priority(x) != -1 || x == '(' || x == ')') {
				if (!num.equals("")){
					postfix.append(num);
					postfix.append(" ");
					num = "";
				}

				// unary 연산이라면 ~로 변환
				if (unary && x == '-') x = '~';

				// x가 괄호라면, 연산의 우선순위가 변경되므로 이를 체크
				// 닫는 괄호가 나올때 여태까지 저장된 연산자들을 모두 출력
				if (x == '(') opeStack.push(x);
				else if (x == ')') {
					while (true) {
						char tmp = opeStack.pop();
						if (tmp == '(') break;
						else {
							postfix.append(tmp);
							postfix.append(" ");
						}
					}
					unary = false;
				}

				else {
					if (opeStack.isEmpty()) opeStack.push(x);

					// pow 연산은 오른쪽부터 처리해야 하므로 별도로 처리
					else if (x == '^' && opeStack.peek() == '^') {
						opeStack.push(x);
						continue;
					}

					// unary 연산 역시도 별도의 처리
					else if (x == '~' && opeStack.peek() == '~') {
						opeStack.push(x);
						continue;
					}

					// 연산자의 우선순위를 비교해서 opeStack top에 있는 연산자보다 우선순위가 높거나 같다면 먼저 postfix에 저장한다.
					else {
						while (!opeStack.isEmpty() && opeStack.peek() != '(' && priority(opeStack.peek()) >= priority(x)) {
							postfix.append(opeStack.pop());
							postfix.append(" ");
						}
						opeStack.push(x);
					}
					unary = true;
				}
			}
		}

		// 아직 남아있는 숫자나 연산자가 있다면 처리
		if(!num.equals("")) {
			postfix.append(num);
			postfix.append(" ");
		}
		while(!opeStack.isEmpty()) {
			char tmp = opeStack.pop();
			postfix.append(tmp);
			postfix.append(" ");
		}

		return postfix.toString();
	}

	// postfix 형태의 수식을 받아서 계산결과를 돌려주는 메소드
	private static long evaluate(String postfix) throws Exception {
		String number = "";
		char ope = ' ';
		Stack <Long> numStack = new Stack<>();
		for (int i = 0; i < postfix.length(); i++) {
			char x = postfix.charAt(i);
			// x가 공백인 경우, 완성된 number를 long형으로 변환하여 numStack에 저장
			if (x == ' ') {
				long num = 0;
				if (number.equals("")) continue;
				for (int j = 0; j < number.length(); j++) {
					char tmp = number.charAt(j);
					num *= 10;
					num += (tmp - '0');
				}
				numStack.push(num);
				number = "";
			}

			// x가 숫자인 경우, number 문자열에 추가
			if ('0' <= x && x <= '9') number += x;

			// x가 연산자인 경우, ope에 대입 후 연산
			if (priority(x) != -1) {

				// x가 unary인 경우는 별도로, numStack에서 가장 최근의 원소의 부호를 변경
				if (x == '~') {
					long num = numStack.pop();
					num *= -1;
					numStack.push(num);
				}

				// 현재 연산자가 나온 상태이므로 가장 최근의 두 수를 연산
				else {
					ope = x;
					long num2 = numStack.pop();
					if (numStack.isEmpty()) throw new Exception("ERROR");
 					long num1 = numStack.pop();
					switch (ope) {
						case '+' :
							numStack.push(num1 + num2);
							break;
						case '-' :
							numStack.push(num1 - num2);
							break;
						case '*' :
							numStack.push(num1 * num2);
							break;
						case '/' :
							if (num2 == 0) throw new Exception("ERROR");
							numStack.push(num1 / num2);
							break;
						case '%' :
							if (num2 == 0) throw new Exception("ERROR");
							numStack.push(num1 % num2);
							break;
						case '^' :
							if (num1 == 0 && num2 < 0) throw new Exception("ERROR");
							numStack.push((long) Math.pow(num1, num2));
							break;
						default:
							throw new Exception("ERROR");
					}
				}
			}
		}

		// 모든 계산 수행 이후에 numStack에 들어있는 원소를 리턴
		return numStack.pop();
	}
}
