<!-- SPDX-License-Identifier: CC-BY-4.0 -->
<!-- Copyright (c) 2026 Youcef Lemsafer -->

© 2026 Youcef Lemsafer -- CC BY 4.0

# Computing the k-nacci numbers

For any integer $k \ge 2$ the generalized Fibonacci numbers which are also called k-nacci numbers or k-Fibonacci numbers
are defined as follows:

$$
\begin{aligned}
& G_{i} = 0 \qquad (0 \le i \lt k-2) \\
& G_{k-1} = 1 \\
& G_{n} = G_{n-1} + ... + G_{n-k} \qquad (n \ge k)
\end{aligned}
$$

For $k=2$ the sequence is simply the well known Fibonacci sequence ($F_0=0, F_1=1$ and $F_{n}=F_{n-1}+F_{n-2}$ for $n \ge 2$). The goal is to derive a way to quickly
compute G_{n}, to do that we use doubling formulas and a binary Lucas chain, more precisely let
$T_{n} = (G_{n}, ..., G_{n+k-1})$ if we can find a map $T_{n} \mapsto T_{2n}$, then we can use the binary
expansion of $n$ to compute $G_{n}$.
To establish the map $T_{n} \mapsto T_{2n}$ we use  theorem 4.1 in [1].

## k = 2, the Fibonacci numbers

For k=2 we have the classical identity for the Fibonacci sequence

$$
\begin{aligned}
& F_{2n} = F_{n}^{2} + 2F_{n-1}F_{n} = F_{n}^{2} + 2(F_{n+1} - F_{n})F_{n} = 2F_{n+1}F_{n} - F_{n}^{2} \\
& F_{2n+1} = F_{n}^{2} + F_{n+1}^{2}
\end{aligned}
$$

Hence the algorithm to compute F_{n}:

```
Returns F(n) for n >= 0
fibonacci(n):
    if(n < 2) return n;
    t = (0, 1);
    m = largest power of 2 <= n;
    while(m != 0) {
        t0 = 2*t[1]*t[0] - t[0]^2;
        t[1] = t[0]^2 + t[1]^2;
        t[0] = t0;
        if((m & n) != 0) {
            t1 = t[0] + t[1];
            t[0] = t[1];
            t[1] = t1;
        }
        m = m >> 1;
    }
    return t[0];
```

## k = 3, the tribonacci numbers

Using theorem 4.1 in [1] with $r=3$ we get

$$
\begin{aligned}
& G_{2n} = G_{n}^{2} + G_{n+1}^{2} + 2G_{n-1}G_{n} \qquad (1) \\
& G_{2n+1} = G_{n}^{2} + G_{n+1}^{2} + 2G_{n-1}G_{n+1} + 2G_{n}G_{n+1}
\end{aligned}
$$

Since by definition of the sequence $G_{n-1} = G_{n+2} - G_{n} - G_{n+1}$, the previous identities become

$$
\begin{aligned}
G_{2n} &= G_{n}^{2} + G_{n+1}^{2} + 2(G_{n+2} - G_{n} - G_{n+1})G_{n} \\
             &= G_{n+1}^{2} - G_{n}^{2} + 2(G_{n+2} - G_{n+1})G_{n} \\
G_{2n+1} &= G_{n}^{2} + G_{n+1}^{2} + 2(G_{n+2} - G_{n} - G_{n+1})G_{n+1} + 2G_{n}G_{n+1} \\
                  &= G_{n}^{2} + 2G_{n+2}G_{n+1} - G_{n+1}^{2} 
\end{aligned}
$$

And finally

$$
\begin{aligned}
& G_{2n} = G_{n+1}^{2} - G_{n}^{2} + 2(G_{n+2} - G_{n+1})G_{n} \\
& G_{2n+1} = G_{n}^{2} + 2G_{n+2}G_{n+1} - G_{n+1}^{2} \\
& G_{2n+2} = G_{n+1}^{2} + G_{n+2}^{2} + 2G_{n}G_{n+1}
\end{aligned}
$$

the last identity being obtained by replacing $n$ by $n+1$ in (1).

From these last three identities we deduce an algorithm to compute $G_{n}$ in $log2(n)$ steps

```
// Returns G(n) (k = 3) for n >= 0
tribonacci(n):
    t = (0, 0, 1);
    if(n < 3) return t[n];
    m = largest power of two <= n;
    while(m != 0) {
        tt = (); // size 2 array
        tt[0] = t[1]^2 - t[0]^2 + 2*(t[2] - t[1])*t[0];
        tt[1] = t[0]^2 + 2*t[2]*t[1] - t[1]^2;
        t[2] = t[1]^2 + t[2]^2 + 2*t[0]*t[1];
        t[0] = tt[0];
        t[1] = tt[1];
        if((m & n) != 0) {
            t2 = t[0] + t[1] + t[2];
            t[0] = t[1];
            t[1] = t[2];
            t[2] = t2;
        }
        m = m >> 1;
    }
    return t[0];
```



## k = 4, the tetranacci numbers

From theorem 4.1 in [1] we get

$$
G_{2n} = G_{n}^{2} - G_{n+1}^{2} + 2G_{n-1}G_{n} + 2G_{n+1}G_{n+2}    \qquad\qquad  (1)
$$

$$
G_{2n+1} = G_{n}^{2} + G_{n+1}^{2} + G_{n+2}^{2} + 2G_{n-1}G_{n+1} + 2G_{n}G_{n+1}   \qquad   (2)
$$

By definition of the sequence $G_{n-1} + G_{n} + G_{n+1} + G_{n+2} = G_{n+3}$ thus $G_{n-1} = G_{n+3} - G_{n+2} - G_{n+1} - G_{n}$

Hence

$$
   G_{2n} = G_{n}^{2} - G_{n+1}^{2} + 2(G_{n+3} - G_{n+2} - G_{n+1} - G_{n})G_{n} + 2G_{n+1}G_{n+2}
$$

$$
          = -G_{n}^{2} - G_{n+1}^{2} + 2(G_{n+3} - G_{n+2} - G_{n+1})G_{n} + 2G_{n+1}G_{n+2}
$$

$$
          = 2(G_{n+3} - G_{n+2})G_{n} + 2(G_{n+2} - G_{n})G_{n+1} - G_{n+1}^{2} - G_{n}^{2}
$$

$$
    G_{2n+1} = G_{n}^{2} + G_{n+1}^{2} + G_{n+2}^{2} + 2(G_{n+3} - G_{n+2} - G_{n+1} - G_{n})G_{n+1} + 2G_{n}G_{n+1}
$$

$$
             = G_{n+2}^{2} + G_{n}^{2} - G_{n+1}^{2} + 2(G_{n+3} - G_{n+2})G_{n+1}
$$

Now we have $G_{2n}$ and $G_{2n+1}$ expressed in terms of $G_{n}, G_{n+1}, G_{n+2}, G_{n+3}$ we also need $G_{2n+2}$ and $G_{2n+3}$
expressed in terms of $G_{n}, G_{n+1}, G_{n+2}, G_{n+3}$. To get that we need only replace $n$ by $n+1$ in (1) and (2):

$$
G_{2n+2} = G_{n+1}^{2} - G_{n+2}^{2} + 2G_{n}G_{n+1} + 2G_{n+2}G_{n+3}
$$

$$
G_{2n+3} = G_{n+1}^{2} + G_{n+2}^{2} + G_{n+3}^{2} + 2G_{n}G_{n+2} + 2G_{n+1}G_{n+2}
$$

Putting it all together:

$$
G_{2n} = 2(G_{n+3} - G_{n+2})G_{n} + 2(G_{n+2} - G_{n})G_{n+1} - G_{n+1}^{2} - G_{n}^{2}
$$

$$
G_{2n+1} = G_{n+2}^{2} - G_{n+1}^{2} + G_{n}^{2} + 2(G_{n+3} - G_{n+2})G_{n+1}
$$

$$
G_{2n+2} = G_{n+1}^{2} + 2G_{n}G_{n+1} + 2G_{n+2}G_{n+3} - G_{n+2}^{2}
$$

$$
G_{2n+3} = G_{n+1}^{2} + G_{n+2}^{2} + G_{n+3}^{2} + 2(G_{n} + G_{n+1})G_{n+2}
$$

From this last four identities we deduce a way to compute the tetranacci numbers in $O(log(n))$ operations:

```
tetranacci(n):
    t = {0,0,0,1};
    if(n < 4) return t[n];
    m = 2^floor(log2(n)); /* Start from most significant bit of n */
    while(m != 0) {
        tt = {0, 0, 0};
        tt[0] = 2*((t[3] - t[2])*t[0] + (t[2] - t[0])*t[1]) - t[1]^2 - t[0]^2;
        tt[1] = t[2]^2 - t[1]^2 + t[0]^2 + 2*(t[3] - t[2])*t[1];
        tt[2] = t[1]^2 + 2*(t[0]*t[1] + t[2]*t[3]) - t[2]^2;
        t[3] = t[1]^2 + t[2]^2 +  t[3]^2 + 2*(t[0] + t[1])*t[2];
        t[0] = tt[0]; t[1] = tt[1]; t[2] = tt[2];
        if((m & n) != 0) {
            t4 = t[0] + t[1] + t[2] + t[3];
            t[0] = t[1]; t[1] = t[2]; t[2] = t[3]; t[3] = t4;
        }
        m = m >> 1;
    }
    return t[0];
```

## k >= 5, the pentanacci, hexanacci, heptanacci, etc. numbers

Clearly as k grows the symbolic computations needed to get the map $T_{n} \mapsto T_{2n}$ quickly become unbearably tedious and error-prone.
To get the job done I used the machine: I made an AI generate a Python script which uses SymPy to perform the symbolic computation and generate the
code.
The script is available here. By invoking it this way (assumes the code is in a file named k-nacci.py in the current folder):

```
$ isympy
>>> exec(open('k-nacci.py').read())
>>> generate_rnacci_doubling(2, 0)
\begin{align*}
  G_{2n} &= - G_{n}^2 + 2 G_{n} G_{n+1} \\
  G_{2n+1} &= G_{n}^2 + G_{n+1}^2
\end{align*}
>>> generate_rnacci_doubling(3, 0)
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} + 2 G_{n} G_{n+2} + G_{n+1}^2 \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 + 2 G_{n+1} G_{n+2} \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 + G_{n+2}^2
\end{align*}
>>> generate_rnacci_doubling(4, lang=0)
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} - 2 G_{n} G_{n+2} + 2 G_{n} G_{n+3} - G_{n+1}^2 + 2 G_{n+1} G_{n+2} \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 - 2 G_{n+1} G_{n+2} + 2 G_{n+1} G_{n+3} + G_{n+2}^2 \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 - G_{n+2}^2 + 2 G_{n+2} G_{n+3} \\
  G_{2n+3} &= 2 G_{n} G_{n+2} + G_{n+1}^2 + 2 G_{n+1} G_{n+2} + G_{n+2}^2 + G_{n+3}^2
\end{align*}
```

We get the doubling formulas we established for $k=2$:

$$
\begin{align*}
  G_{2n} &= - G_{n}^2 + 2 G_{n} G_{n+1} \\
  G_{2n+1} &= G_{n}^2 + G_{n+1}^2
\end{align*}
$$

for $k=3$:

$$
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} + 2 G_{n} G_{n+2} + G_{n+1}^2 \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 + 2 G_{n+1} G_{n+2} \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 + G_{n+2}^2
\end{align*}
$$

and for $k=4$:

$$
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} - 2 G_{n} G_{n+2} + 2 G_{n} G_{n+3} - G_{n+1}^2 + 2 G_{n+1} G_{n+2} \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 - 2 G_{n+1} G_{n+2} + 2 G_{n+1} G_{n+3} + G_{n+2}^2 \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 - G_{n+2}^2 + 2 G_{n+2} G_{n+3} \\
  G_{2n+3} &= 2 G_{n} G_{n+2} + G_{n+1}^2 + 2 G_{n+1} G_{n+2} + G_{n+2}^2 + G_{n+3}^2
\end{align*}
$$

Now getting the formulas for k=5, 6, 7, ... is a matter of invoking the generate_rnacci_doubling function in [k-nacci.py](./k-nacci.py).
The second parameter of the function controls which output to produce: if lang=0, as seen above, the formulas are
generated in LaTeX, if lang=1 the generated output is ready for use in C/C++ code, lastly if lang=2 the
generated code is ready for use in PARI/GP code.

In the sections below we give the results for $k=5$ and $k=6$. As the value of k grows, the explicit algebraic expressions
scale in length and become impractical to display. For direct computational usage and verification a PARI/GP implementation
is provided in the accompanying [k-nacci.gp](./k-nacci.gp) file.


### k=5, the pentanacci numbers

#### Doubling formulas

$$
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} - 2 G_{n} G_{n+2} - 2 G_{n} G_{n+3} + 2 G_{n} G_{n+4} - G_{n+1}^2 - 2 G_{n+1} G_{n+2} + 2 G_{n+1} G_{n+3} + G_{n+2}^2 \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 - 2 G_{n+1} G_{n+2} - 2 G_{n+1} G_{n+3} + 2 G_{n+1} G_{n+4} - G_{n+2}^2 + 2 G_{n+2} G_{n+3} \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 - G_{n+2}^2 - 2 G_{n+2} G_{n+3} + 2 G_{n+2} G_{n+4} + G_{n+3}^2 \\
  G_{2n+3} &= 2 G_{n} G_{n+2} + G_{n+1}^2 + 2 G_{n+1} G_{n+2} + G_{n+2}^2 - G_{n+3}^2 + 2 G_{n+3} G_{n+4} \\
  G_{2n+4} &= 2 G_{n} G_{n+3} + 2 G_{n+1} G_{n+2} + 2 G_{n+1} G_{n+3} + G_{n+2}^2 + 2 G_{n+2} G_{n+3} + G_{n+3}^2 + G_{n+4}^2
\end{align*}
$$

#### C code

```c
v1 = t[0] * t[0];
v2 = t[0] * t[1];
v3 = t[0] * t[2];
v4 = t[0] * t[3];
v5 = t[1] * t[1];
v6 = t[1] * t[2];
v7 = t[1] * t[3];
v8 = t[2] * t[2];
v9 = t[2] * t[3];
v10 = t[3] * t[3];

tt[0] = 2*t[0]*t[4] + 2*v7 + v8 - v1 - 2*v2 - 2*v3 - 2*v4 - v5 - 2*v6;
tt[1] = v1 + 2*t[1]*t[4] + 2*v9 - v5 - 2*v6 - 2*v7 - v8;
tt[2] = 2*v2 + v5 + 2*t[2]*t[4] + v10 - v8 - 2*v9;
tt[3] = 2*v3 + v5 + 2*v6 + v8 + 2*t[3]*t[4] - v10;
t[4] = 2*v4 + 2*v6 + 2*v7 + v8 + 2*v9 + v10 + t[4] * t[4];
```

### k=6, the hexanacci numbers

#### Doubling formulas

$$
\begin{align*}
  G_{2n} &= - G_{n}^2 - 2 G_{n} G_{n+1} - 2 G_{n} G_{n+2} - 2 G_{n} G_{n+3} - 2 G_{n} G_{n+4} + 2 G_{n} G_{n+5} - G_{n+1}^2 - 2 G_{n+1} G_{n+2} - 2 G_{n+1} G_{n+3} + 2 G_{n+1} G_{n+4} - G_{n+2}^2 + 2 G_{n+2} G_{n+3} \\
  G_{2n+1} &= G_{n}^2 - G_{n+1}^2 - 2 G_{n+1} G_{n+2} - 2 G_{n+1} G_{n+3} - 2 G_{n+1} G_{n+4} + 2 G_{n+1} G_{n+5} - G_{n+2}^2 - 2 G_{n+2} G_{n+3} + 2 G_{n+2} G_{n+4} + G_{n+3}^2 \\
  G_{2n+2} &= 2 G_{n} G_{n+1} + G_{n+1}^2 - G_{n+2}^2 - 2 G_{n+2} G_{n+3} - 2 G_{n+2} G_{n+4} + 2 G_{n+2} G_{n+5} - G_{n+3}^2 + 2 G_{n+3} G_{n+4} \\
  G_{2n+3} &= 2 G_{n} G_{n+2} + G_{n+1}^2 + 2 G_{n+1} G_{n+2} + G_{n+2}^2 - G_{n+3}^2 - 2 G_{n+3} G_{n+4} + 2 G_{n+3} G_{n+5} + G_{n+4}^2 \\
  G_{2n+4} &= 2 G_{n} G_{n+3} + 2 G_{n+1} G_{n+2} + 2 G_{n+1} G_{n+3} + G_{n+2}^2 + 2 G_{n+2} G_{n+3} + G_{n+3}^2 - G_{n+4}^2 + 2 G_{n+4} G_{n+5} \\
  G_{2n+5} &= 2 G_{n} G_{n+4} + 2 G_{n+1} G_{n+3} + 2 G_{n+1} G_{n+4} + G_{n+2}^2 + 2 G_{n+2} G_{n+3} + 2 G_{n+2} G_{n+4} + G_{n+3}^2 + 2 G_{n+3} G_{n+4} + G_{n+4}^2 + G_{n+5}^2
\end{align*}
$$

#### C code

```c
v1 = t[0] * t[0];
v2 = t[0]*t[1];
v3 = t[0]*t[2];
v4 = t[0]*t[3];
v5 = t[0]*t[4];
v6 = t[1] * t[1];
v7 = t[1]*t[2];
v8 = t[1]*t[3];
v9 = t[1]*t[4];
v10 = t[2] * t[2];
v11 = t[2]*t[3];
v12 = t[2]*t[4];
v13 = t[3] * t[3];
v14 = t[3]*t[4];
v15 = t[4] * t[4];

tt[0] = 2*t[0]*t[5] + 2*v9 + 2*v11 - v1 - 2*v2 - 2*v3 - 2*v4 - 2*v5 - v6 - 2*v7 - 2*v8 - v10;
tt[1] = v1 + 2*t[1]*t[5] + 2*v12 + v13 - v6 - 2*v7 - 2*v8 - 2*v9 - v10 - 2*v11;
tt[2] = 2*v2 + v6 + 2*t[2]*t[5] + 2*v14 - v10 - 2*v11 - 2*v12 - v13;
tt[3] = 2*v3 + v6 + 2*v7 + v10 + 2*t[3]*t[5] + v15 - v13 - 2*v14;
tt[4] = 2*v4 + 2*v7 + 2*v8 + v10 + 2*v11 + v13 + 2*t[4]*t[5] - v15;
t[5] = 2*v5 + 2*v8 + 2*v9 + v10 + 2*v11 + 2*v12 + v13 + 2*v14 + v15 + t[5] * t[5];
```



[1] _Some identities for r-Fibonacci numbers,_ August 2011, F.T. Howard, Curtis Cooper
