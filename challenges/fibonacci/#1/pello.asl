!print_pell(10).
+!print_pell(N)
        <- !pell_num(N, P);
           .print("Pell number at position ", N, " is ", P).

    +!pell_num(N, P) : N == 0
        <- P = 0.

    +!pell_num(N, P) : N == 1
        <- P = 1.

    +!pell_num(N, P) : N > 1
        <- !pell_num(N-1, P1);
           !pell_num(N-2, P2);
           P = 2 * P1 + P2.
