float rand2d (fixed2 st) {
    return frac(sin(dot(st.xy,
                         fixed2(12.9898,78.233)))*
        43758.5453123);
}
