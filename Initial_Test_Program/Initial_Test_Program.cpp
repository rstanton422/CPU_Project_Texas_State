// Programmer: David S. Vasquez
// Date: April 8, 2017
// Information: This is the initial program that we will use to
// test the Obsidian processor, written using C++.

int addition(int, int);
int subtraction(int, int);
int multiplication(int, int);
int division(int, int);

int main() {
  int number1;
  int number2;
	
  int result;
	
  number1 = 10;
  number2 = 10;
	
  result = multiplication(number1, number2);
  result = addition(result, number1);
  result = subtraction(number1, result);
  result = division(number1, result);
	
  return result;
}

int addition(int x, int y) {
  int addResult;
	
  addResult = x + y;
	
  return addResult;
}

int subtraction(int x, int y) {
  int subtractResult;
	
  subtractResult = y - x;
	
  return subtractResult;
}

int multiplication(int x, int y) {
  int multipleResult;
	
  multipleResult = x * y;
	
  return multipleResult;
}

int division(int x, int y) {
  int divideResult;
	
  divideResult = y / x;
	
  return divideResult;
}
