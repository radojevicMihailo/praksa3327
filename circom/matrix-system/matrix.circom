pragma circom  2.0.3;

include "node_modules/circomlib-matrix/circuits/matMul.circom";

template SolveSystemOfLinEq(m, n, p) {

    // Declaration of signals.
    signal input A[m][n];
    signal input X[n][p];
    signal input B[m][p];
    signal Xm[m][p];
    signal output out;

    // Constraints.

    component mul = matMul(m, n, p);
    
    mul.a <== A;
    mul.b <== X;

    Xm <== mul.out;
    
    signal tmp[m*p + 1];
    tmp[0] <== 1;

    for (var i = 0; i < m; i++) {
        for (var j = 0; j < p; j++) {
            tmp[i*p + j + 1] <-- Xm[i][j] != B[i][j] ? 0 : tmp[i*p + j];
        }
    }

    out <== tmp[m * p];
    log("Tacno: ", out);

}

component main {public[A, B]} = SolveSystemOfLinEq(3, 3, 1);
