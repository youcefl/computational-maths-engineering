<!-- SPDX-License-Identifier: CC-BY-4.0 -->
<!-- Copyright (c) 2026 Youcef Lemsafer -->

© 2026 Youcef Lemsafer -- CC BY 4.0


Computing Smarandache base $b$ in $O(log(n))$ big integer operations


The goal is to derive a formula for computing $Sm_b(n)$ in a faster way than the
naive one which takes $O(n)$ big integer operations.


From here on we denote by $Sm_b(n)$ the n-th Smarandache base b number which is
simply the concatenation of the representation in base $b$ of the first $n$
integers:

$$
Sm_b(n) = 123...\overline{n}_{b}
$$

where $\overline{n}_{b}$ is the base $b$ representation of $n$

The naive way to compute $Sm_b(n)$ is to simply loop over the integers 1 to $n$
and append the base $b$ representation of the current integer:

SmNaive(b, n):
result := 0
for i in 1..n:
  result := result*b^SizeInBase(b, i) + result
return result

where SizeInBase(b, i) is the number of digits in the base b representation of
i.


Clearly the number of digits in $\overline{i}_{b}$ which is

$$
1 + \lfloor \dfrac{log(i)}{log(b)} \rfloor
$$

is constant as long as $i$ does not cross a power of $b$ so that for ${b}^{k} \leq n < {b}^{k + 1}$ we have

$$
    Sm_b(n) = Sm_b({b}^k - 1) \cdot {b}^{(k + 1)(n - {b}^{k} + 1)} + \sum_{i=b^k}^{n} {i \cdot {b}^{(k + 1)(n - i)}}      (1)
$$

Let $c_k = Sm_b({b}^{k} - 1)$ and $s(k, n) = \sum_{i=b^k}^{n}{i \cdot {b}^{(k + 1)(n - i)}}$

We have

$$
    Sm_b(n) = c_k\cdot{b}^{(k + 1)(n - {b}^{k} + 1)} + s(k, n)
$$

$s(n,k)$ is computed using the derivative of the geometric sum. We give the result:

$$
    s(n, k) = \dfrac{
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
              = (c_k*b^((k + 1)*(b^(k + 1) - b^k))*(b^(k + 1) - 1)^2
                 + b^((b - 1)*(k + 1)*b^k)*(b^(2*k + 1) - b^k + 1)
                    - (b^(k + 1) - 1)^2
                    - b^(k + 1)
                )/(b^(k + 1) - 1)^2
             =  (c_k*b^((b - 1)*(k + 1)*b^k)*(b^(k + 1) - 1)^2
                 + b^((b - 1)*(k + 1)*b^k)*(b^(2*k + 1) - b^k + 1)
                    - (b^(k + 1) - 1)^2
                    - b^(k + 1)
                )/(b^(k + 1) - 1)^2
$$

and finally

$$
    c_{k + 1} = ((c_k*(b^(k + 1) - 1)^2 + b^(2*k + 1) - b^k + 1)*b^((b - 1)*(k + 1)*b^k)
                 - (b^(k + 1) - 1)^2
                 - b^(k + 1)
                )/(b^(k + 1) - 1)^2
$$

Also we have
$$
    Sm_b(n) = c_k*b^((k + 1)*(n - b^k + 1)) + s(k, n)
           = c_k*b^((k + 1)*(n - b^k + 1)) + (
                b^((k + 1)*(n - b^k + 1))*(b^(2*k + 1) - b^k + 1)
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
           = (c_k*b^((k + 1)*(n - b^k + 1))*(b^(k + 1) - 1)^2
             + b^((k + 1)*(n - b^k + 1))*(b^(2*k + 1) - b^k + 1)
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
           = ((c_k*(b^(k + 1) - 1)^2 + b^(2*k + 1) - b^k + 1)* b^((k + 1)*(n - b^k + 1))
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
$$

Thus in order to compute $Sm_b(n)$ one needs only compute the constants $C_k$ (up until $k = floor(logb(n))$)
and use the relation
$$
    Sm_b(n) = ((c_k*(b^(k + 1) - 1)^2 + b^(2*k + 1) - b^k + 1)* b^((k + 1)*(n - b^k + 1))
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
$$

If we define

$$
    C_k = c_k*(b^(k + 1) - 1)^2 + b^(2*k + 1) - b^k + 1
$$

we have

$$
    Sm_b(n) = (C_k* b^((k + 1)*(n - b^k + 1))
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
$$

To be able to use this form we need only derive a recurrence relation for C_k.

We have $C_0 = b$, and

$$
    C_{k + 1} = c_{k + 1}*(b^(k + 2) - 1)^2 + b^(2*k + 3) - b^(k + 1) + 1
              = ((c_k*(b^(k + 1) - 1)^2 + b^(2*k + 1) - b^k + 1)*b^((b - 1)*(k + 1)*b^k)
                 - (b^(k + 1) - 1)^2
                 - b^(k + 1)
                )/(b^(k + 1) - 1)^2
                *(b^(k + 2) - 1)^2 + b^(2*k + 3) - b^(k + 1) + 1
$$

Since
$$
    c_k = (C_k - b^(2*k + 1) + b^k - 1)/(b^(k + 1) - 1)^2
$$
thus
$$
    C_{k + 1} = (C_k*b^((b - 1)*(k + 1)*b^k)
                 - (b^(k + 1) - 1)^2
                 - b^(k + 1)
                )/(b^(k + 1) - 1)^2
                *(b^(k + 2) - 1)^2 + b^(2*k + 3) - b^(k + 1) + 1
$$

We conclude with the following algorithm for computing Smarandache base b.

$$
---------------------------------
n: integer >= 0
Return Sm_b(n)
---------------------------------
Sm_b(n):
    if(n < 2) return n;
    k = floor(log(n)/log(b))
    // Compute C_k using the recurrence relation
    C_k = ...
    return (C_k* b^((k + 1)*(n - b^k + 1))
                - (b^(k + 1) - 1)*n
                - b^(k + 1)
              )/(b^(k + 1) - 1)^2
$$

