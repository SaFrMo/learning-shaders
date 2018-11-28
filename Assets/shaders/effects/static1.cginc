float static1(fixed2 uv){
    return rand2d(
        floor(uv.x * 100.0) +
        floor(uv.y * 100.0) +
        floor(_Time / 0.02)
    );
}
