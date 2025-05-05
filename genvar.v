genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin // <- can also add ' : loopname '
        some_module u (
            .in(a[i*4 +: 4])  // selects bits [i*4+3 : i*4]
        );
    end
endgenerate