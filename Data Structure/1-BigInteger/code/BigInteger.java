import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BigInteger {
    public static final String QUIT_COMMAND = "quit";
    public static final String MSG_INVALID_INPUT = "Invalid input!";
    public static final Pattern EXPRESSION_PATTERN = Pattern.compile("");

    byte sign;
    byte[] expr;

    public BigInteger(String s) {
        s = s.trim();
        char x = s.charAt(0);
        if (x == '+' || x == '-') {
            s = s.substring(1);
            s = s.trim();
        }
        if (x == '-') this.sign = -1;
        else this.sign = 1;
        int len = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == ' ') break;
            len++;
        }
        this.expr = new byte[len];
        for (int i = 0; i < len; i++) {
            this.expr[i] = (byte) (s.charAt(i)-'0');
        }
    }

    public BigInteger(byte negative, byte[] numbers) {
        this.sign = negative;
        this.expr = numbers;
    }

    public BigInteger add(BigInteger big) {
        if (this.sign != big.sign) {
            if (big.sign == 1) big.sign = -1;
            else big.sign = 1;
            return this.subtract(big);
        }
        BigInteger res = new BigInteger((byte) 1, new byte[1]);
        res.sign = big.sign;
        int maxLength, minLength;
        BigInteger bigger, smaller;
        if (big.expr.length > this.expr.length){
            maxLength = big.expr.length;
            minLength = this.expr.length;
            bigger = big;
            smaller = this;
        }
        else {
            maxLength = this.expr.length;
            minLength = big.expr.length;
            bigger = this;
            smaller = big;
        }
        res.expr = new byte[maxLength+1];
        int carry = 0;
        int diff = maxLength - minLength;
        for (int i = 0; i < minLength; i++) {
            int plus = bigger.expr[minLength-i-1+diff] + smaller.expr[minLength-i-1] + carry;
            if (plus >= 10) {
                plus -= 10;
                carry = 1;
            }
            else carry = 0;
            res.expr[minLength-i+diff] = (byte) plus;
        }
        for (int i = diff-1; i >= 0; i--) {
            int plus = bigger.expr[i] + carry;
            if (plus >= 10) {
                plus -= 10;
                carry = 1;
            }
            else carry = 0;
            res.expr[i+1] = (byte) plus;
        }
        if (carry >= 1) res.expr[0] = 1;
        else {
            byte[] tmp = new byte[maxLength];
            for (int i = 0; i < maxLength; i++) {
                tmp[i] = res.expr[i + 1];
            }
            res.expr = tmp;
        }
        return res;
    }

    public BigInteger subtract(BigInteger big) {
        if (this.sign != big.sign) {
            if (big.sign == 1) big.sign = -1;
            else big.sign = 1;
            return this.add(big);
        }
        BigInteger res = new BigInteger((byte) 1, new byte[1]);
        int maxLength, minLength;
        BigInteger bigger = new BigInteger((byte) 1, new byte[1]);
        BigInteger smaller = new BigInteger((byte) 1, new byte[1]);
        if (big.expr.length > this.expr.length){
            if (this.sign == 1) res.sign = -1;
            else res.sign = 1;
            maxLength = big.expr.length;
            minLength = this.expr.length;
            bigger = big;
            smaller = this;
        }
        else if (big.expr.length < this.expr.length) {
            if (this.sign == 1) res.sign = 1;
            else res.sign = -1;
            maxLength = this.expr.length;
            minLength = big.expr.length;
            bigger = this;
            smaller = big;
        }
        else {
            maxLength = minLength = big.expr.length;
            for (int i = 0; i < maxLength; i++) {
                if (big.expr[i] > this.expr[i]) {
                    if (this.sign == 1) res.sign = -1;
                    else res.sign = 1;
                    bigger = big;
                    smaller = this;
                    break;
                }
                else if (big.expr[i] < this.expr[i]) {
                    if (this.sign == 1) res.sign = 1;
                    else res.sign = -1;
                    bigger = this;
                    smaller = big;
                    break;
                }
                if (i == maxLength-1) {
                    BigInteger zeroRes = new BigInteger((byte) 1, new byte[1]);
                    zeroRes.sign = 1;
                    zeroRes.expr[0] = 0;
                    return zeroRes;
                }
            }
        }
        int carry = 0;
        int diff = maxLength - minLength;
        res.expr = new byte[maxLength];
        for (int i = 0; i < minLength; i++) {
            int minus = bigger.expr[minLength-i-1+diff] - smaller.expr[minLength-i-1] + carry;
            if (minus < 0) {
                minus += 10;
                carry = -1;
            }
            else carry = 0;
            res.expr[minLength-i+diff-1] = (byte) minus;
        }
        for (int i = diff-1; i >= 0; i--) {
            int minus = bigger.expr[i] + carry;
            if (minus < 0) {
                minus += 10;
                carry = -1;
            }
            else carry = 0;
            res.expr[i] = (byte) minus;
        }
        int len = 0;
        for (int i = 0; i < maxLength; i++) {
            if (res.expr[i] != 0) break;
            len++;
        }
        byte[] exprTmp = new byte[res.expr.length-len];
        for (int i = 0; i < res.expr.length-len; i++) {
            exprTmp[i] = res.expr[i + len];
        }
        res.expr = exprTmp;
        return res;
    }

    public BigInteger multiply(BigInteger big) {
        BigInteger res = new BigInteger((byte) 1, new byte[1]);
        if (this.sign == big.sign) res.sign = 1;
        else res.sign = -1;
        res.expr = new byte[this.expr.length + big.expr.length];
        for (int i = this.expr.length-1; i >= 0; i--) {
            for (int j = big.expr.length-1; j >= 0; j--) {
                int multi = this.expr[i] * big.expr[j];
                res.expr[i+j+1] += multi % 10;
                res.expr[i+j] += multi / 10;
                res.expr[i+j] += res.expr[i+j+1] / 10;
                res.expr[i+j+1] = (byte) (res.expr[i+j+1] % 10);
            }
        }
        for (int i = res.expr.length - 1; i >= 1; i--) {
            res.expr[i-1] += res.expr[i] / 10;
            res.expr[i] = (byte) (res.expr[i] % 10);
        }
        int len = 0;
        for (int i = 0; i < res.expr.length; i++) {
            if (i == res.expr.length-1 && res.expr[i] == 0) {
                len = res.expr.length-1;
                res.sign = 1;
                break;
            }
            if (res.expr[i] != 0) break;
            len++;
        }
        byte[] tmp = new byte[res.expr.length-len];
        for (int i = 0; i < res.expr.length-len; i++) tmp[i] = res.expr[i + len];
        res.expr = tmp;
        return res;
    }

    @Override
    public String toString() {
        StringBuilder build = new StringBuilder();
        if (this.sign == -1) build.append("-");
        for (int i = 0; i < this.expr.length; i++) build.append(this.expr[i]);
        return build.toString();
    }

    static BigInteger evaluate(String input) throws IllegalArgumentException {
        int ope = 0;
        input.trim();
        int flag = 0;
        for (int i = 0; i < input.length(); i++) {
            if (flag == 1 && (input.charAt(i) == '+' || input.charAt(i) == '-' || input.charAt(i) == '*')) {
                ope = i;
                break;
            }
            if(input.charAt(i) >= '0' && input.charAt(i) <= '9') flag = 1;
        }
        String arg1 = input.substring(0, ope);
        String arg2 = input.substring(ope+1);
        BigInteger num1 = new BigInteger(arg1);
        BigInteger num2 = new BigInteger(arg2);
        BigInteger answer = new BigInteger((byte) 1, new byte[1]);
        switch (input.charAt(ope)) {
            case '+':
                answer = num1.add(num2);
                break;
            case '-':
                answer = num1.subtract(num2);
                break;
            case '*':
                answer = num1.multiply(num2);
                break;
        }
        return answer;
    }

    public static void main(String[] args) throws Exception {
        try (InputStreamReader isr = new InputStreamReader(System.in)) {
            try (BufferedReader reader = new BufferedReader(isr)) {
                boolean done = false;
                while (!done) {
                    String input = reader.readLine();
                    try {
                        done = processInput(input);
                    }
                    catch (IllegalArgumentException e) {
                        System.err.println(MSG_INVALID_INPUT);
                    }
                }
            }
        }
    }

    static boolean processInput(String input) throws IllegalArgumentException {
        boolean quit = isQuitCmd(input);
        if (quit) {
            return true;
        }
        else {
            BigInteger result = evaluate(input);
            System.out.println(result.toString());
            return false;
        }
    }

    static boolean isQuitCmd(String input) {
        return input.equalsIgnoreCase(QUIT_COMMAND);
    }
}
