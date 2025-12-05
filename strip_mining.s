vst R0, #0
Loop:   load R7, R1[R0] ; a_re[i] value
        load R8, R2[R0] ; b_re[i] value
        load R9, R3[R0] ; a_im[i] value
        load R10, R4[R0] ; b_im[i] value
        mul R11, R7, R8
        mul R12, R9, R10
        sub R13, R11, R12
        store R5[R0], R13
        mul R14, R10, R7
        mul R15, R9, R8
        add R16, R14, R15
        store R6[R0], R16
        ADD R0, R0, #1
        BLT R0, #300 Loop
        
 
li t0, 300

loop:
    vsetvli t1, t0, e32
    vle32.v v0, (a_re)
    vle32.v v1, (a_im)
    vle32.v v2, (b_re)
    vle32.v v3, (b_im)
    
    vfmul.vv v4, v0, v2
    vfmul.vv v5, v1, v3
    vfsub.vv v6, v4, v5
    
    vfmul.vv v7, v0, v3
    vfmul.vv v8, v1, v2
    vfadd.vv v9, v7, v8
    
    vse32.v v6, (c_re)
    vse32.v v9, (c_im)
    
    slli t2, t1, 2
    add a_re, a_re, t2
    add b_re, b_re, t2
    add a_im, a_im, t2
    add b_im, b_im, t2
    add c_im, c_im, t2
    add c_re, c_re, t2
    
    sub t0,t0, t1
    bnez t0, loop

# RV64V Assembly code using strip mining. Equivalent C code:
# for (int i = 0; i < 300; i++) {
# c_re[i] = a_re[i] * b_re[i]  a_im[i] * b_im[i];
# c_im[i] = a_re[i] * b_im[i] + a_im[i] * b_re[i];
#}
