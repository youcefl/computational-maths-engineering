
# Computing k-nacci numbers

## k=4, the tetranacci numbers

From theorem 4.1 in [1] we get

$$
G_{2n} = G_{n}^{2} − G_{n+1}^{2} + 2G_{n−1}G_{n} + 2G_{n+1}G_{n+2}    \qquad\qquad  (1)
$$

$$
G_{2n+1} = G_{n}^{2} + G_{n+1}^{2} + G_{n+2}^{2} + 2G_{n−1}G_{n+1} + 2G_{n}G_{n+1}   \qquad   (2)
$$

By definition of the sequence $G_{n-1} + G_{n} + G_{n+1} + G_{n+2} = G_{n+3}$ thus $G_{n-1} = G_{n+3} - G_{n+2} - G_{n+1} - G_{n}$

Hence

$$
   G_{2n} = G_{n}^{2} − G_{n+1}^{2} + 2(G_{n+3} - G_{n+2} - G_{n+1} - G_{n})G_{n} + 2G_{n+1}G_{n+2}
$$

$$
          = -G_{n}^{2} − G_{n+1}^{2} + 2(G_{n+3} - G_{n+2} - G_{n+1})G_{n} + 2G_{n+1}G_{n+2}
$$

$$
          = 2(G_{n+3} - G_{n+2})G_{n} + 2(G_{n+2} - G_{n})G_{n+1} - G_{n+1}^{2} − G_{n}^{2}
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
G_{2n+2} = G_{n+1}^{2} − G_{n+2}^{2} + 2G_{n}G_{n+1} + 2G_{n+2}G_{n+3}
$$

$$
G_{2n+3} = G_{n+1}^{2} + G_{n+2}^{2} + G_{n+3}^{2} + 2G_{n}G_{n+2} + 2G_{n+1}G_{n+2}
$$

Putting it all together:

$$
G_{2n} = 2(G_{n+3} - G_{n+2})G_{n} + 2(G_{n+2} - G_{n})G_{n+1} - G_{n+1}^{2} − G_{n}^{2}
$$

$$
G_{2n+1} = G_{n+2}^{2} - G_{n+1}^{2} + G_{n}^{2} + 2(G_{n+3} - G_{n+2})G_{n+1}
$$

$$
G_{2n+2} = G_{n+1}^{2} + 2G_{n}G_{n+1} + 2G_{n+2}G_{n+3} − G_{n+2}^{2}
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


[1] _Some identities for r-Fibonacci numbers,_ August 2011, F.T. Howard, Curtis Cooper
