pragma circom  2.0.3;

include "node_modules/circomlib-matrix/circuits/matMul.circom";
include "node_modules/circomlib-matrix/circuits/transpose.circom";

template SolveSystemOfLinEq(m, n, p) {

    // Declaration of signals.
    signal input A[m][n];
    signal input B[n][p];
    signal input X[m][p];
    signal At[n][m];
    signal Aadj[n][m];
    signal Ainv[n][m];
    signal Xm[m][p];
    signal output out;

    // Constraints.

    component tran = transpose(m, n);

    tran.a <== A;
    At <== tran.out;

    for (var i = 0; i < n; i++) {
        for (var j = 0; j < m; j++) {
            log(At[i][j]);
        }
    }

    for (var i = 0; i < n; i++) {
        for (var j = 0; j < p; j++) {
            log(B[i][j]);
        }
    }

    for (var i = 0; i < m; i++) {
        for (var j = 0; j < p; j++) {
            log(X[i][j]);
        }
    }

    component mul = matMul(m, n, p);

    // Umesto A treba da stoji inverzna matrica od A. Nisam uspeo to da izracunam.
    
    mul.a <== A;
    mul.b <== B;

    Xm <== mul.out;
    
    signal tmp[m*p + 1];
    tmp[0] <== 1;

    for (var i = 0; i < m; i++) {
        for (var j = 0; j < p; j++) {
            tmp[i*p + j + 1] <-- Xm[i][j] != X[i][j] ? 0 : tmp[i*n + j];
        }
    }

    out <== tmp[m * p];
    log(out);

}

component main = SolveSystemOfLinEq(3, 3, 1);
