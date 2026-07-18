/* SPDX-License-Identifier: CC-BY-4.0
* Copyright (c) 2026 Youcef Lemsafer */

/* © 2026 Youcef Lemsafer -- CC BY 4.0 */

/*
* Returns the n-th k-nacci (AKA k-Fibonacci) number
* Assumes k >= 2
* Naive iterative version
*/
knacci_naive(k, n) = {
    if(n < k-1, return(0));
    if(n == k-1, return(1));
    my(t = vector(k, i, i == k));
    for(i=k, n,
        my(l = vecsum(t));
        for(j=1, k-1, t[j] = t[j+1]);
        t[k] = l
    );
    return(t[k]);
}

knacci(k, n, perform_doubling) = {
    my(t = vector(k, i, i == k));
    if (n < k, return(t[n + 1]));
    my(m = 1 << (logint(n, 2)));
    my(tt = vector(k - 1), t_next);
    while(m != 0,
        perform_doubling(~t, ~tt);
        for(i = 1, k - 1, t[i] = tt[i]);
        if (bitand(n, m) != 0,
            t_next = vecsum(t);
            for(i = 1, k - 1, t[i] = t[i + 1]);
            t[k] = t_next;
        );
        m >>= 1;
    );
    return(t[1]);
}

/* k = 2, Fibonacci naive iterative */
/* Could also use PARI/GP native fibonacci function */
fibonacci_naive(n) = {
    return(knacci_naive(2, n));
}

/* k = 2, Fibonacci using derived doubling formulas */
fibonacci_fast(n) = {
    return(knacci(2, n, (~t, ~tt) ->
        my(v1 = t[1]^2);
        tt[1] = 2*t[1]*t[2] - v1;
        t[2] = v1 + t[2]^2;
    ));
}

/* k = 3, tribonacci naive iterative */
tribonacci_naive(n) = {
    return(knacci_naive(3, n));
}

/* k = 3, tribonacci using derived doubling formulas */
tribonacci(n) = {
    return(knacci(3, n, (~t, ~tt) ->
        my(v1 = t[1]^2,
           v2 = t[1]*t[2],
           v3 = t[2]^2
        );
        tt[1] = 2*t[1]*t[3] + v3 - v1 - 2*v2;
        tt[2] = v1 + 2*t[2]*t[3] - v3;
        t[3] = 2*v2 + v3 + t[3]^2;
    ));
}

/* k = 4, tetranacci naive iterative */
tetranacci_naive(n) = {
    return(knacci_naive(4, n));
}

/* k = 4, tetranacci using derived doubling formulas */
tetranacci(n) = {
    return(knacci(4, n, (~t, ~tt) ->
        my(v1 = t[1]^2,
           v2 = t[1]*t[2],
           v3 = t[1]*t[3],
           v4 = t[2]^2,
           v5 = t[2]*t[3],
           v6 = t[3]^2
        );
        tt[1] = 2*t[1]*t[4] + 2*v5 - v1 - 2*v2 - 2*v3 - v4;
        tt[2] = v1 + 2*t[2]*t[4] + v6 - v4 - 2*v5;
        tt[3] = 2*v2 + v4 + 2*t[3]*t[4] - v6;
        t[4] = 2*v3 + v4 + 2*v5 + v6 + t[4]^2;
    ));
}


/* k = 5, pentanacci naive iterative */
pentanacci_naive(n) = {
    return(knacci_naive(5, n));
}

/* k = 5, pentanacci using derived doubling formulas */
pentanacci(n) = {
    return(knacci(5, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2],
           v3 = t[1]*t[3], v4 = t[1]*t[4],
           v5 = t[2]^2, v6 = t[2]*t[3],
           v7 = t[2]*t[4], v8 = t[3]^2,
           v9 = t[3]*t[4], v10 = t[4]^2
        );
        tt[1] = 2*t[1]*t[5] + 2*v7 + v8 - v1 - 2*v2 - 2*v3 - 2*v4 - v5 - 2*v6;
        tt[2] = v1 + 2*t[2]*t[5] + 2*v9 - v5 - 2*v6 - 2*v7 - v8;
        tt[3] = 2*v2 + v5 + 2*t[3]*t[5] + v10 - v8 - 2*v9;
        tt[4] = 2*v3 + v5 + 2*v6 + v8 + 2*t[4]*t[5] - v10;
        t[5] = 2*v4 + 2*v6 + 2*v7 + v8 + 2*v9 + v10 + t[5]^2;
    ));
}

/* k = 6, hexanacci naive iterative */
hexanacci_naive(n) = {
    return(knacci_naive(6, n));
}

/* k = 6, hexanacci using derived doubling formulas */
hexanacci(n) = {
    return(knacci(6, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2], v3 = t[1]*t[3], v4 = t[1]*t[4],
           v5 = t[1]*t[5], v6 = t[2]^2, v7 = t[2]*t[3], v8 = t[2]*t[4],
           v9 = t[2]*t[5], v10 = t[3]^2, v11 = t[3]*t[4], v12 = t[3]*t[5],
           v13 = t[4]^2, v14 = t[4]*t[5], v15 = t[5]^2
        );
        tt[1] = 2*t[1]*t[6] + 2*v9 + 2*v11 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - v6 - 2*v7 - 2*v8 - v10;
        tt[2] = v1 + 2*t[2]*t[6] + 2*v12 + v13 - v6 - 2*v7 - 2*v8 - 2*v9 - v10 - 2*v11;
        tt[3] = 2*v2 + v6 + 2*t[3]*t[6] + 2*v14 - v10 - 2*v11 - 2*v12 - v13;
        tt[4] = 2*v3 + v6 + 2*v7 + v10 + 2*t[4]*t[6] + v15 - v13 - 2*v14;
        tt[5] = 2*v4 + 2*v7 + 2*v8 + v10 + 2*v11 + v13 + 2*t[5]*t[6] - v15;
        t[6] = 2*v5 + 2*v8 + 2*v9 + v10 + 2*v11 + 2*v12 + v13 + 2*v14 + v15 + t[6]^2;
    ));
}

/* k = 7, heptanacci naive iterative */
heptanacci_naive(n) = {
    return(knacci_naive(7, n));
}

/* k = 7, heptanacci using derived doubling formulas */
heptanacci(n) = {
    return(knacci(7, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2], v3 = t[1]*t[3], v4 = t[1]*t[4],
            v5 = t[1]*t[5], v6 = t[1]*t[6], v7 = t[2]^2, v8 = t[2]*t[3],
            v9 = t[2]*t[4], v10 = t[2]*t[5], v11 = t[2]*t[6], v12 = t[3]^2,
            v13 = t[3]*t[4], v14 = t[3]*t[5], v15 = t[3]*t[6], v16 = t[4]^2,
            v17 = t[4]*t[5], v18 = t[4]*t[6], v19 = t[5]^2, v20 = t[5]*t[6],
            v21 = t[6]^2
        );
        tt[1] = 2*t[1]*t[7] + 2*v11 + 2*v14 + v16 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - 2*v6 - v7 - 2*v8 - 2*v9 - 2*v10 - v12 - 2*v13;
        tt[2] = v1 + 2*t[2]*t[7] + 2*v15 + 2*v17 - v7 - 2*v8 - 2*v9 - 2*v10 - 2*v11 - v12 - 2*v13 - 2*v14 - v16;
        tt[3] = 2*v2 + v7 + 2*t[3]*t[7] + 2*v18 + v19 - v12 - 2*v13 - 2*v14 - 2*v15 - v16 - 2*v17;
        tt[4] = 2*v3 + v7 + 2*v8 + v12 + 2*t[4]*t[7] + 2*v20 - v16 - 2*v17 - 2*v18 - v19;
        tt[5] = 2*v4 + 2*v8 + 2*v9 + v12 + 2*v13 + v16 + 2*t[5]*t[7] + v21 - v19 - 2*v20;
        tt[6] = 2*v5 + 2*v9 + 2*v10 + v12 + 2*v13 + 2*v14 + v16 + 2*v17 + v19 + 2*t[6]*t[7] - v21;
        t[7] = 2*v6 + 2*v10 + 2*v11 + 2*v13 + 2*v14 + 2*v15 + v16 + 2*v17 + 2*v18 + v19 + 2*v20 + v21 + t[7]^2;
    ));
}


/* k = 8, octanacci naive iterative */
octanacci_naive(n) = {
    return(knacci_naive(8, n));
}

/* k = 8, octanacci using derived doubling formulas */
octanacci(n) = {
    return(knacci(8, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2], v3 = t[1]*t[3], v4 = t[1]*t[4],
            v5 = t[1]*t[5], v6 = t[1]*t[6], v7 = t[1]*t[7], v8 = t[2]^2,
            v9 = t[2]*t[3], v10 = t[2]*t[4], v11 = t[2]*t[5], v12 = t[2]*t[6],
            v13 = t[2]*t[7], v14 = t[3]^2, v15 = t[3]*t[4], v16 = t[3]*t[5],
            v17 = t[3]*t[6], v18 = t[3]*t[7], v19 = t[4]^2, v20 = t[4]*t[5],
            v21 = t[4]*t[6], v22 = t[4]*t[7], v23 = t[5]^2, v24 = t[5]*t[6],
            v25 = t[5]*t[7], v26 = t[6]^2, v27 = t[6]*t[7], v28 = t[7]^2
        );
        tt[1] = 2*t[1]*t[8] + 2*v13 + 2*v17 + 2*v20 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - 2*v6 - 2*v7 - v8 - 2*v9 - 2*v10 - 2*v11 - 2*v12 - v14 - 2*v15 - 2*v16 - v19;
        tt[2] = v1 + 2*t[2]*t[8] + 2*v18 + 2*v21 + v23 - v8 - 2*v9 - 2*v10 - 2*v11 - 2*v12 - 2*v13 - v14 - 2*v15 - 2*v16 - 2*v17 - v19 - 2*v20;
        tt[3] = 2*v2 + v8 + 2*t[3]*t[8] + 2*v22 + 2*v24 - v14 - 2*v15 - 2*v16 - 2*v17 - 2*v18 - v19 - 2*v20 - 2*v21 - v23;
        tt[4] = 2*v3 + v8 + 2*v9 + v14 + 2*t[4]*t[8] + 2*v25 + v26 - v19 - 2*v20 - 2*v21 - 2*v22 - v23 - 2*v24;
        tt[5] = 2*v4 + 2*v9 + 2*v10 + v14 + 2*v15 + v19 + 2*t[5]*t[8] + 2*v27 - v23 - 2*v24 - 2*v25 - v26;
        tt[6] = 2*v5 + 2*v10 + 2*v11 + v14 + 2*v15 + 2*v16 + v19 + 2*v20 + v23 + 2*t[6]*t[8] + v28 - v26 - 2*v27;
        tt[7] = 2*v6 + 2*v11 + 2*v12 + 2*v15 + 2*v16 + 2*v17 + v19 + 2*v20 + 2*v21 + v23 + 2*v24 + v26 + 2*t[7]*t[8] - v28;
        t[8] = 2*v7 + 2*v12 + 2*v13 + 2*v16 + 2*v17 + 2*v18 + v19 + 2*v20 + 2*v21 + 2*v22 + v23 + 2*v24 + 2*v25 + v26 + 2*v27 + v28 + t[8]^2;
    ));
}


/* k = 9, enneanacci naive iterative */
enneanacci_naive(n) = {
    return(knacci_naive(9, n));
}

/* k = 9, enneanacci using derived doubling formulas */
enneanacci(n) = {
    return(knacci(9, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2], v3 = t[1]*t[3], v4 = t[1]*t[4],
            v5 = t[1]*t[5], v6 = t[1]*t[6], v7 = t[1]*t[7], v8 = t[1]*t[8],
            v9 = t[2]^2, v10 = t[2]*t[3], v11 = t[2]*t[4], v12 = t[2]*t[5],
            v13 = t[2]*t[6], v14 = t[2]*t[7], v15 = t[2]*t[8], v16 = t[3]^2,
            v17 = t[3]*t[4], v18 = t[3]*t[5], v19 = t[3]*t[6], v20 = t[3]*t[7],
            v21 = t[3]*t[8], v22 = t[4]^2, v23 = t[4]*t[5], v24 = t[4]*t[6],
            v25 = t[4]*t[7], v26 = t[4]*t[8], v27 = t[5]^2, v28 = t[5]*t[6],
            v29 = t[5]*t[7], v30 = t[5]*t[8], v31 = t[6]^2, v32 = t[6]*t[7],
            v33 = t[6]*t[8], v34 = t[7]^2, v35 = t[7]*t[8], v36 = t[8]^2
        );
        tt[1] = 2*t[1]*t[9] + 2*v15 + 2*v20 + 2*v24 + v27 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - 2*v6 - 2*v7 - 2*v8 - v9 - 2*v10 - 2*v11 - 2*v12 - 2*v13 - 2*v14 - v16 - 2*v17 - 2*v18 - 2*v19 - v22 - 2*v23;
        tt[2] = v1 + 2*t[2]*t[9] + 2*v21 + 2*v25 + 2*v28 - v9 - 2*v10 - 2*v11 - 2*v12 - 2*v13 - 2*v14 - 2*v15 - v16 - 2*v17 - 2*v18 - 2*v19 - 2*v20 - v22 - 2*v23 - 2*v24 - v27;
        tt[3] = 2*v2 + v9 + 2*t[3]*t[9] + 2*v26 + 2*v29 + v31 - v16 - 2*v17 - 2*v18 - 2*v19 - 2*v20 - 2*v21 - v22 - 2*v23 - 2*v24 - 2*v25 - v27 - 2*v28;
        tt[4] = 2*v3 + v9 + 2*v10 + v16 + 2*t[4]*t[9] + 2*v30 + 2*v32 - v22 - 2*v23 - 2*v24 - 2*v25 - 2*v26 - v27 - 2*v28 - 2*v29 - v31;
        tt[5] = 2*v4 + 2*v10 + 2*v11 + v16 + 2*v17 + v22 + 2*t[5]*t[9] + 2*v33 + v34 - v27 - 2*v28 - 2*v29 - 2*v30 - v31 - 2*v32;
        tt[6] = 2*v5 + 2*v11 + 2*v12 + v16 + 2*v17 + 2*v18 + v22 + 2*v23 + v27 + 2*t[6]*t[9] + 2*v35 - v31 - 2*v32 - 2*v33 - v34;
        tt[7] = 2*v6 + 2*v12 + 2*v13 + 2*v17 + 2*v18 + 2*v19 + v22 + 2*v23 + 2*v24 + v27 + 2*v28 + v31 + 2*t[7]*t[9] + v36 - v34 - 2*v35;
        tt[8] = 2*v7 + 2*v13 + 2*v14 + 2*v18 + 2*v19 + 2*v20 + v22 + 2*v23 + 2*v24 + 2*v25 + v27 + 2*v28 + 2*v29 + v31 + 2*v32 + v34 + 2*t[8]*t[9] - v36;
        t[9] = 2*v8 + 2*v14 + 2*v15 + 2*v19 + 2*v20 + 2*v21 + 2*v23 + 2*v24 + 2*v25 + 2*v26 + v27 + 2*v28 + 2*v29 + 2*v30 + v31 + 2*v32 + 2*v33 + v34 + 2*v35 + v36 + t[9]^2;
    ));
}


/* k = 10, decanacci naive iterative */
decanacci_naive(n) = {
    return(knacci_naive(10, n));
}

/* k = 10, decanacci using derived doubling formulas */
decanacci(n) = {
    return(knacci(10, n, (~t, ~tt) ->
        my(v1 = t[1]^2, v2 = t[1]*t[2], v3 = t[1]*t[3], v4 = t[1]*t[4],
            v5 = t[1]*t[5], v6 = t[1]*t[6], v7 = t[1]*t[7], v8 = t[1]*t[8],
            v9 = t[1]*t[9], v10 = t[2]^2, v11 = t[2]*t[3], v12 = t[2]*t[4],
            v13 = t[2]*t[5], v14 = t[2]*t[6], v15 = t[2]*t[7], v16 = t[2]*t[8],
            v17 = t[2]*t[9], v18 = t[3]^2, v19 = t[3]*t[4], v20 = t[3]*t[5],
            v21 = t[3]*t[6], v22 = t[3]*t[7], v23 = t[3]*t[8], v24 = t[3]*t[9],
            v25 = t[4]^2, v26 = t[4]*t[5], v27 = t[4]*t[6], v28 = t[4]*t[7],
            v29 = t[4]*t[8], v30 = t[4]*t[9], v31 = t[5]^2, v32 = t[5]*t[6],
            v33 = t[5]*t[7], v34 = t[5]*t[8], v35 = t[5]*t[9], v36 = t[6]^2,
            v37 = t[6]*t[7], v38 = t[6]*t[8], v39 = t[6]*t[9], v40 = t[7]^2,
            v41 = t[7]*t[8], v42 = t[7]*t[9], v43 = t[8]^2, v44 = t[8]*t[9],
            v45 = t[9]^2
        );
        tt[1] = 2*t[10]*t[1] + 2*v17 + 2*v23 + 2*v28 + 2*v32 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - 2*v6 - 2*v7 - 2*v8 - 2*v9 - v10 - 2*v11 - 2*v12 - 2*v13 - 2*v14 - 2*v15 - 2*v16 - v18 - 2*v19 - 2*v20 - 2*v21 - 2*v22 - v25 - 2*v26 - 2*v27 - v31;
        tt[2] = 2*t[10]*t[2] + v1 + 2*v24 + 2*v29 + 2*v33 + v36 - v10 - 2*v11 - 2*v12 - 2*v13 - 2*v14 - 2*v15 - 2*v16 - 2*v17 - v18 - 2*v19 - 2*v20 - 2*v21 - 2*v22 - 2*v23 - v25 - 2*v26 - 2*v27 - 2*v28 - v31 - 2*v32;
        tt[3] = 2*t[10]*t[3] + 2*v2 + v10 + 2*v30 + 2*v34 + 2*v37 - v18 - 2*v19 - 2*v20 - 2*v21 - 2*v22 - 2*v23 - 2*v24 - v25 - 2*v26 - 2*v27 - 2*v28 - 2*v29 - v31 - 2*v32 - 2*v33 - v36;
        tt[4] = 2*t[10]*t[4] + 2*v3 + v10 + 2*v11 + v18 + 2*v35 + 2*v38 + v40 - v25 - 2*v26 - 2*v27 - 2*v28 - 2*v29 - 2*v30 - v31 - 2*v32 - 2*v33 - 2*v34 - v36 - 2*v37;
        tt[5] = 2*t[10]*t[5] + 2*v4 + 2*v11 + 2*v12 + v18 + 2*v19 + v25 + 2*v39 + 2*v41 - v31 - 2*v32 - 2*v33 - 2*v34 - 2*v35 - v36 - 2*v37 - 2*v38 - v40;
        tt[6] = 2*t[10]*t[6] + 2*v5 + 2*v12 + 2*v13 + v18 + 2*v19 + 2*v20 + v25 + 2*v26 + v31 + 2*v42 + v43 - v36 - 2*v37 - 2*v38 - 2*v39 - v40 - 2*v41;
        tt[7] = 2*t[10]*t[7] + 2*v6 + 2*v13 + 2*v14 + 2*v19 + 2*v20 + 2*v21 + v25 + 2*v26 + 2*v27 + v31 + 2*v32 + v36 + 2*v44 - v40 - 2*v41 - 2*v42 - v43;
        tt[8] = 2*t[10]*t[8] + 2*v7 + 2*v14 + 2*v15 + 2*v20 + 2*v21 + 2*v22 + v25 + 2*v26 + 2*v27 + 2*v28 + v31 + 2*v32 + 2*v33 + v36 + 2*v37 + v40 + v45 - v43 - 2*v44;
        tt[9] = 2*t[10]*t[9] + 2*v8 + 2*v15 + 2*v16 + 2*v21 + 2*v22 + 2*v23 + 2*v26 + 2*v27 + 2*v28 + 2*v29 + v31 + 2*v32 + 2*v33 + 2*v34 + v36 + 2*v37 + 2*v38 + v40 + 2*v41 + v43 - v45;
        t[10] = t[10]^2 + 2*v9 + 2*v16 + 2*v17 + 2*v22 + 2*v23 + 2*v24 + 2*v27 + 2*v28 + 2*v29 + 2*v30 + v31 + 2*v32 + 2*v33 + 2*v34 + 2*v35 + v36 + 2*v37 + 2*v38 + 2*v39 + v40 + 2*v41 + 2*v42 + v43 + 2*v44 + v45;
    ));
}

