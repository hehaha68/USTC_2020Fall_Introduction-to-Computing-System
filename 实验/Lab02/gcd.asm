START   .ORIG   X3000
        NOT     R2,R0
        ADD     R2,R2,#1;取反加一变负数
        ADD     R2,R2,R1;比大小
        BRnz    GCD;如果R0较大,进行取余
        JSR     SWAP;如果R0较小,进行交换
GCD     NOT     R2,R1;
        ADD     R2,R2,#1;取反加一变负数
REM     ADD     R0,R0,R2;
        BRzp    REM;用减法取余
        ADD     R0,R0,R1;
        BRz     GCDEND;如果余数为0则结束
        JSR     SWAP;如果余数不为0，继续辗转相除
        BR      GCD;
GCDEND  JSR     SWAP;让R0存结果
        TRAP x21
        HALT
;
SWAP    ADD     R2,R0,#0;交换
        ADD     R0,R1,#0
        ADD     R1,R2,#0
        RET
;
        .END