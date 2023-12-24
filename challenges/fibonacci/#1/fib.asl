!print_fib(3).

+!print_fib(N)
   <- !fibo_num(N, F);
      .print("Fibonacci number at position ", N, " is ", F).

+!fibo_num(N, 0) : N == 0.

+!fibo_num(N, 1) : N == 1.

+!fibo_num(N, F) : N > 1
   <- !fibo_num(N-1, F1);
      !fibo_num(N-2, F2);
      F = F1 + F2.


