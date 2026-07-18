# SPDX-License-Identifier: CC-BY-4.0
# Copyright (c) 2026 Youcef Lemsafer

# © 2026 Youcef Lemsafer -- CC BY 4.0

from collections import Counter
import sympy as sp
from sympy import symbols, expand

def generate_rnacci_doubling(r, lang=1):
    """
    Generates optimized r-nacci doubling formulas.
    
    Parameters:
    r (int): The order of the sequence (e.g., 8 for octanacci).
    lang (int): 0 for LaTeX formulas, 1 for C/C++ optimized, 2 for PARI/GP (1-based).
    """
    max_needed = 2 * r
    names = [f'G_{{{i}}}' for i in range(-1, max_needed)]
    G = symbols(names)
    
    def G_at(idx):
        return G[idx + 1]
    
    def A_i(i, n_idx):
        if i < r - 2:
            start = n_idx + r - i - 1
            s = 0
            for j in range(1, r - i - 1):
                s += G_at(n_idx + j)
            return G_at(start) - s
        else:
            return G_at(n_idx + 1)
    
    def formula_G2n_at(n_idx):
        result = G_at(n_idx)**2 + 2*G_at(n_idx - 1)*G_at(n_idx)
        for i in range(1, r-1):
            result += G_at(n_idx + i) * A_i(i, n_idx)
        return expand(result)
    
    def formula_G2n1_at(n_idx):
        result = G_at(n_idx)*G_at(n_idx+1) + G_at(n_idx)**2 + G_at(n_idx-1)*G_at(n_idx+1)
        for i in range(1, r-1):
            result += G_at(n_idx + i) * A_i(i, n_idx + 1)
        return expand(result)
    
    # 1 to 4. Algebraic Derivation and Window Rollback
    results = []
    for j in range(r):
        shift = j // 2
        if j % 2 == 0:
            formula = formula_G2n_at(shift)
        else:
            formula = formula_G2n1_at(shift)
        
        if shift == 0:
            G_minus_1 = G_at(r-1) - sum(G_at(k) for k in range(r-1))
            formula = expand(formula.subs(G_at(-1), G_minus_1))
        
        while True:
            atoms = formula.atoms()
            indices = [int(str(a).split('{')[1].split('}')[0]) for a in atoms if str(a).startswith('G_')]
            if not indices: break
            max_idx = max(indices)
            if max_idx < r: break
            replacement = sum(G_at(max_idx - 1 - k) for k in range(r))
            formula = expand(formula.subs(G_at(max_idx), replacement))
        
        results.append(formula)
        
    # --- Mode 0: LaTeX Output Handling ---
    if lang == 0:
        print(f"\\begin{{align*}}")
        # Define clean mappings for printing variables inside the formula
        latex_mapping = {}
        for i in range(r):
            if i == 0:
                latex_mapping[f"G_{{0}}"] = "G_{n}"
            else:
                latex_mapping[f"G_{{{i}}}"] = f"G_{{n+{i}}}"

        for j, formula in enumerate(results):
            sorted_args = sorted(formula.args, key=lambda x: str(x.as_coeff_mul()[1]))
            formatted_terms = []
            for arg in sorted_args:
                coeff, tail = arg.as_coeff_mul()
                
                # Format variables cleanly and substitute the dynamic indexing
                raw_terms = []
                for t in tail:
                    t_str = str(t).replace('**2', '^2')
                    for src, dest in latex_mapping.items():
                        t_str = t_str.replace(src, dest)
                    raw_terms.append(t_str)
                
                term_str = " ".join(raw_terms)
                
                if coeff == 1:
                    formatted_terms.append(f"+ {term_str}")
                elif coeff == -1:
                    formatted_terms.append(f"- {term_str}")
                elif coeff > 0:
                    formatted_terms.append(f"+ {coeff} {term_str}")
                else:
                    formatted_terms.append(f"- {abs(coeff)} {term_str}")
            
            expr_str = " ".join(formatted_terms).strip()
            if expr_str.startswith("+ "): expr_str = expr_str[2:]
            
            if j == 0:
                label = "G_{2n}"
            else:
                label = f"G_{{2n+{j}}}"
                
            suffix = " \\\\" if j < r - 1 else ""
            print(f"  {label} &= {expr_str}{suffix}")
        print(f"\\end{{align*}}")
        return

    # --- Code Generation Modes (1 = C/C++, 2 = PARI/GP) ---
    offset = 1 if lang == 2 else 0
    pow_sym = "^" if lang == 2 else " * "
    
    state_mapping = {G_at(i): sp.Symbol(f"t[{i+offset}]") for i in range(r)}
    mapped_formulas = [expand(f.subs(state_mapping)) for f in results]
    
    prod_counts = Counter()
    for f in mapped_formulas:
        for arg in f.args:
            coeff, tail = arg.as_coeff_mul()
            if len(tail) == 1 and isinstance(tail[0], sp.Pow) and tail[0].exp == 2:
                prod_counts[tail[0]] += 1
            elif len(tail) == 2:
                prod_counts[tail[0] * tail[1]] += 1

    v_mapping = {}
    v_definitions = []
    v_index = 1
    
    for prod in sorted(list(prod_counts.keys()), key=lambda x: str(x)):
        if prod_counts[prod] >= 2:
            v_sym = sp.Symbol(f"v{v_index}")
            v_mapping[prod] = v_sym
            v_definitions.append((v_sym, prod))
            v_index += 1
        
    def format_term_string(term_expr):
        if lang == 1 and isinstance(term_expr, sp.Pow) and term_expr.exp == 2:
            base_str = str(term_expr.base)
            return f"{base_str} * {base_str}"
        return str(term_expr).replace('**', pow_sym)

    if lang == 1:
        print(f"// Optimized C/C++ formulas for r = {r} (0-based indexing)")
    else:
        print(f"/* Optimized PARI/GP formulas for r = {r} (1-based indexing) */")
    print()
    
    if v_definitions:
        if lang == 1:
            print("// Precomputed common subexpressions")
            vars_list = ", ".join([f"v{i}" for i in range(1, v_index)])
            print(f"BigInt {vars_list};")
            
        for v_sym, prod in v_definitions:
            print(f"{v_sym} = {format_term_string(prod)};")
        print()
        
    for j, f in enumerate(mapped_formulas):
        pos_atoms = []
        neg_atoms = []
        
        for arg in sorted(f.args, key=lambda x: str(x.as_coeff_mul()[1])):
            coeff, tail = arg.as_coeff_mul()
            if len(tail) == 1:
                term_expr = tail[0]
            elif len(tail) == 2:
                term_expr = tail[0]*tail[1]
            else:
                term_expr = 1
            
            if term_expr in v_mapping:
                mapped_term = str(v_mapping[term_expr])
            else:
                mapped_term = format_term_string(term_expr)
                
            abs_coeff = abs(int(coeff))
            if abs_coeff == 1:
                term_str = f"{mapped_term}"
            else:
                term_str = f"{abs_coeff}*{mapped_term}"
                
            if int(coeff) > 0:
                pos_atoms.append(term_str)
            else:
                neg_atoms.append(term_str)
                
        pos_part = " + ".join(pos_atoms)
        neg_part = " - ".join(neg_atoms)
        
        if pos_part and neg_part:
            total_expr = f"{pos_part} - {neg_part}"
        elif pos_part:
            total_expr = pos_part
        else:
            total_expr = f"-({neg_part})"
            
        var_name = f"tt[{j+offset}]" if j < r-1 else f"t[{r-1+offset}]"
        print(f"{var_name} = {total_expr};")
