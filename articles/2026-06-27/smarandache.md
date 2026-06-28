<!-- SPDX-License-Identifier: CC-BY-4.0 -->
<!-- Copyright (c) 2026 Youcef Lemsafer -->

© 2026 Youcef Lemsafer -- CC BY 4.0


# Computing Smarandache base $b$ in $O(log(n))$ big integer operations


**The goal is to derive a formula for computing $Sm_b(n)$ in a faster way than the
naive one which takes $O(n)$ big integer operations.**

## A formula for $Sm_b(n)$

From here on we denote by $Sm_b(n)$ the n-th Smarandache base b number which is
simply the concatenation of the representation in base $b$ of the first $n$
integers:

$$
Sm_b(n) = 123...\overline{n}_{b}
$$

where $\overline{n}_{b}$ is the base $b$ representation of $n$

The naive way to compute $Sm_b(n)$ is to simply loop over the integers 1 to $n$
and append the base $b$ representation of the current integer:

```
---------------------------------
b: integer >= 2
n: integer >= 0
Return Sm_b(n)
---------------------------------
SmNaive(b, n):
if n = 0 then
  return 0;
result := 1;
for i = 1 to n do
  result := result*b^SizeInBase(b, i) + result;
return result;
```

where $SizeInBase(b, i)$ is the number of digits in the base $b$ representation of $i$.


Clearly the number of digits in $\overline{i}_{b}$ which is

$$
1 + \lfloor \dfrac{log(i)}{log(b)} \rfloor
$$

is constant as long as $i$ does not cross a power of $b$ so that for ${b}^{k} \leq n < {b}^{k + 1}$ we have

$$
    Sm_b(n) = Sm_b({b}^k - 1) \cdot {b}^{(k + 1)(n - {b}^{k} + 1)} + \sum_{i=b^k}^{n} {i \cdot {b}^{(k + 1)(n - i)}}      (1)
$$

Let $c_k = Sm_b({b}^{k} - 1)$ and

$$
s(k, n) = \sum_{i=b^k}^{n}{i \cdot {b}^{(k + 1)(n - i)}}
$$

We have

$$
    Sm_b(n) = c_k\cdot{b}^{(k + 1)(n - {b}^{k} + 1)} + s(k, n)
$$

$s(k,n)$ is computed using the derivative of the geometric sum. We give the result:

$$
    s(k, n) = \dfrac{
                {b}^{(k + 1) \cdot (n - {b}^{k} + 1)}({b}^{2 \cdot k + 1} - {b}^{k} + 1)
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}                                                               (2)
$$

$c_k$ can be defined by recurrence in the following way. The first value is $c_0 = Sm_b(0) = 0$,
then, since $c_{k + 1} = Sm_b({b}^{k + 1} - 1)$, substituting $n$ with ${b}^{k + 1} - 1$ in (1) and (2),
we get

$$
    c_{k + 1} = c_k \cdot {b}^{(k + 1)({b}^{k + 1} - {b}^{k})}
                + \dfrac{
                    b^{(b - 1)(k + 1){b}^{k}} \cdot ({b}^{2k + 1} - {b}^{k} + 1)
                    - ({b}^{k + 1} - 1)^2
                    - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
              = \dfrac{c_k \cdot {b}^{(k + 1)({b}^{k + 1} - {b}^{k})} \cdot ({b}^{k + 1} - 1)^2
                 + {b}^{(b - 1)(k + 1){b}^{k}}({b}^{2k + 1} - {b}^{k} + 1)
                    - ({b}^{k + 1} - 1)^2
                    - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
             =  \dfrac{c_k \cdot {b}^{(b - 1)(k + 1){b}^{k}}({b}^{k + 1} - 1)^2
                 + {b}^{(b - 1)(k + 1){b}^{k}}({b}^{2k + 1} - {b}^{k} + 1)
                    - ({b}^{k + 1} - 1)^2
                    - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
$$

and finally

$$
    c_{k + 1} = \dfrac{(c_k \cdot ({b}^{k + 1} - 1)^2 + {b}^{2k + 1} - {b}^{k} + 1) \cdot {b}^{(b - 1)(k + 1){b}^{k}}
                 - ({b}^{k + 1} - 1)^2
                 - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
$$

Also we have

$$
    Sm_b(n) = c_k \cdot b^{(k + 1)(n - {b}^{k} + 1)} + s(k, n)
           = c_k \cdot b^{(k + 1)(n - {b}^{k} + 1)} + \dfrac{
                b^{(k + 1)(n - {b}^{k} + 1)}({b}^{2k + 1} - {b}^{k} + 1)
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}
           = \dfrac{c_k \cdot b^{(k + 1)(n - {b}^{k} + 1)}({b}^{k + 1} - 1)^2
             + {b}^{(k + 1)(n - {b}^{k} + 1)}({b}^{2k + 1} - {b}^{k} + 1)
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}
           = \dfrac{(c_k \cdot ({b}^{k + 1} - 1)^2 + {b}^{2k + 1} - {b}^{k} + 1) \cdot {b}^{(k + 1)(n - {b}^{k} + 1)}
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}
$$

Thus in order to compute $Sm_b(n)$ one needs only compute the constants $c_k$ up until $k = floor(log_b(n))$
and use the relation

$$
    Sm_b(n) = \dfrac{(c_k \cdot ({b}^{k + 1} - 1)^2 + {b}^{2k + 1} - {b}^{k} + 1) {b}^{(k + 1)(n - {b}^{k} + 1)}
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}
$$

If we define

$$
    C_k = c_k \cdot ({b}^{k + 1} - 1)^2 + {b}^{2k + 1} - {b}^{k} + 1
$$

we have

$$
    Sm_b(n) = \dfrac{C_k \cdot b^{(k + 1)(n - {b}^{k} + 1)}
                - ({b}^{k + 1} - 1) \cdot n
                - {b}^{k + 1}
              }{({b}^{k + 1} - 1)^{2}}
$$

To be able to use this form we need only derive a recurrence relation for $C_k$.

We have $C_0 = b$, and

$$
    C_{k + 1} = c_{k + 1} \cdot ({b}^{k + 2} - 1)^2 + {b}^{2k + 3} - {b}^{k + 1} + 1
$$
$$
              = \dfrac{(c_k \cdot ({b}^{k + 1} - 1)^2 + {b}^{2k + 1} - {b}^{k} + 1) \cdot {b}^{(b - 1)(k + 1){b}^{k}}
                 - ({b}^{k + 1} - 1)^2
                 - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
                \cdot ({b}^{k + 2} - 1)^{2} + {b}^{2k + 3} - {b}^{k + 1} + 1
$$

Since

$$
    c_k = \dfrac{C_k - {b}^{2k + 1} + {b}^{k} - 1}{({b}^{k + 1} - 1)^{2}}
$$

we get

$$
    C_{k + 1} = \dfrac{C_k \cdot {b}^{(b - 1)(k + 1){b}^{k}}
                 - ({b}^{k + 1} - 1)^2
                 - {b}^{k + 1}
                }{({b}^{k + 1} - 1)^{2}}
                \cdot ({b}^{k + 2} - 1)^2 + {b}^{2k + 3} - {b}^{k + 1} + 1
$$

We conclude with the following algorithm for computing Smarandache base b.

```
---------------------------------
b: integer >= 2
n: integer >= 0
Return Sm_b(n)
---------------------------------
Sm(b, n):
  if n < 2 then
    return n;
  k := floor(log(n)/log(b));
  // Compute C_k using the recurrence relation above
  C_k = ...
  return (C_k * b^((k + 1)*(n - b^k + 1))
              - (b^(k + 1) - 1)*n
              - b^(k + 1)
              ) / (b^(k + 1) - 1)^2;
```

## Implementation in PARI/GP

In this section we give an implementation of the algorithms above in the GP language and compare their performances.

### GP implementation of the naive version
```
SmNaive(b, n) = {
    my(v = 0);
    my(i = 1);
    while(i <= n,
        my(digits = 1 + logint(i, b));
        v = v * b^digits + i;
        i = i + 1;
    );
    return(v);
}
```

### GP implementation of Sm(b, n)
```
/*
* b is the base
* k is floor(log(n)/log(b))
*/
compute_c_k(b, i) = {
    my(c_k = b);
    my(k = 0);
    while(k < i,
        c_k = (c_k*b^((b - 1)*(k + 1)*b^k)
                 - (b^(k + 1) - 1)^2
                 - b^(k + 1)
                )/(b^(k + 1) - 1)^2
                *(b^(k + 2) - 1)^2 + b^(2*k + 3) - b^(k + 1) + 1;
        k = k + 1;
    );
    return(c_k);
}


Sm(b, n) = {
    if(n < 2,
        return(n);
    );
    my(k = logint(n, b));
    my(c_k = compute_c_k(b, k));
    return((c_k* b^((k + 1)*(n - b^k + 1))
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2);
}

```

### Performance comparison

| Function | b | n | time (ms) | Speed-up | Digits |
|----------|---|---|-----------|----------|--------|
| SmNaive | 10 | 40000 | 860 | 1 | 188894 |
| Sm | 10 | 40000 | 6.2 | 138.7 | 188894 |
| SmNaive | 10 | 100000 | 6181 | 1 | 488895 |
| Sm | 10 | 100000 | 37 | 167 | 488895 |
| SmNaive | 2 | 40000 | 775 | 1 | 172936 |
| Sm | 2 | 40000 | 10 | 77.5 | 172936 |
| SmNaive | 2 | 100000 | 5870 | 1 | 472300 |
| Sm | 2 | 100000 | 21.2 | 276.9 | 472300 |

Note that Sm could be made faster by precomputing the $C_k$ values. The algorithm Sm
given above was implemented in C++ and use in [cutrialdive](https://github.com/youcefl/cutrialdive) (at least in version 1.0.0
of that tool) for outputing expressions which evaluate to Sm(b, n).

