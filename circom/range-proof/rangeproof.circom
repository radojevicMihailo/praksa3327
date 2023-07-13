pragma circom 2.0.3;

include "node_modules/circomlib/circuits/comparators.circom";

template Rangeproof(n) {

    signal input rangeLower;
    signal input rangeUpper;
    signal input in;
    signal output out;
    signal tmp;
    signal tmp1;

    component lte = LessEqThan(n);
    lte.in[0] <== in;
    lte.in[1] <== rangeUpper;
    tmp <== lte.out;

    component gte = GreaterEqThan(n);
    gte.in[0] <== in;
    gte.in[1] <== rangeLower;
    tmp1 <== gte.out;

    out <== tmp * tmp1;
    log("Result ia: ", out);

}

component main {public[rangeLower, rangeUpper]} = Rangeproof(64);
