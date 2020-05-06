//
//File: RijndaelPreliminaries.svh
//Device: 
//Created:  2017-3-29 23:01:41
//Description: algorithm preliminaries
//Revisions: 
//2017-3-29 23:01:57: created
//

`ifndef __RIJNDAEL_PRELIMINARIES_SVH__
`define __RIJNDAEL_PRELIMINARIES_SVH__
virtual class RijndaelPreliminaries extends LogBase;
    typedef bit [31:0] tWORD;

    static protected function bit[7:0] xtime(
        bit [7:0] x
    );
        xtime = {x[6:0], 1'b0};
        if (x[7] == 1)
            xtime ^= 8'h1b;
    endfunction

    static function bit[7:0] GF8Mult (
        bit[7:0] x, y
    );
        if (y == 0)
            return 0;
        else
            return (y[0]?x:0)^GF8Mult(xtime(x), {1'b0, y[7:1]});
    endfunction

    const static protected bit[7:0] sbox[256] = {
        8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01, 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76, 
        8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0, 
        8'hb7, 8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5, 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15, 
        8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75, 
        8'h09, 8'h83, 8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84, 
        8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf, 
        8'hd0, 8'hef, 8'haa, 8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8, 
        8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2, 
        8'hcd, 8'h0c, 8'h13, 8'hec, 8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73, 
        8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee, 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb, 
        8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79, 
        8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56, 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08, 
        8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a, 
        8'h70, 8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35, 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e, 
        8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf, 
        8'h8c, 8'ha1, 8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16
    };

    const static protected bit[7:0] invSbox[256] = {
        8'h52, 8'h09, 8'h6a, 8'hd5, 8'h30, 8'h36, 8'ha5, 8'h38, 8'hbf, 8'h40, 8'ha3, 8'h9e, 8'h81, 8'hf3, 8'hd7, 8'hfb,
        8'h7c, 8'he3, 8'h39, 8'h82, 8'h9b, 8'h2f, 8'hff, 8'h87, 8'h34, 8'h8e, 8'h43, 8'h44, 8'hc4, 8'hde, 8'he9, 8'hcb,
        8'h54, 8'h7b, 8'h94, 8'h32, 8'ha6, 8'hc2, 8'h23, 8'h3d, 8'hee, 8'h4c, 8'h95, 8'h0b, 8'h42, 8'hfa, 8'hc3, 8'h4e,
        8'h08, 8'h2e, 8'ha1, 8'h66, 8'h28, 8'hd9, 8'h24, 8'hb2, 8'h76, 8'h5b, 8'ha2, 8'h49, 8'h6d, 8'h8b, 8'hd1, 8'h25,
        8'h72, 8'hf8, 8'hf6, 8'h64, 8'h86, 8'h68, 8'h98, 8'h16, 8'hd4, 8'ha4, 8'h5c, 8'hcc, 8'h5d, 8'h65, 8'hb6, 8'h92,
        8'h6c, 8'h70, 8'h48, 8'h50, 8'hfd, 8'hed, 8'hb9, 8'hda, 8'h5e, 8'h15, 8'h46, 8'h57, 8'ha7, 8'h8d, 8'h9d, 8'h84,
        8'h90, 8'hd8, 8'hab, 8'h00, 8'h8c, 8'hbc, 8'hd3, 8'h0a, 8'hf7, 8'he4, 8'h58, 8'h05, 8'hb8, 8'hb3, 8'h45, 8'h06,
        8'hd0, 8'h2c, 8'h1e, 8'h8f, 8'hca, 8'h3f, 8'h0f, 8'h02, 8'hc1, 8'haf, 8'hbd, 8'h03, 8'h01, 8'h13, 8'h8a, 8'h6b,
        8'h3a, 8'h91, 8'h11, 8'h41, 8'h4f, 8'h67, 8'hdc, 8'hea, 8'h97, 8'hf2, 8'hcf, 8'hce, 8'hf0, 8'hb4, 8'he6, 8'h73,
        8'h96, 8'hac, 8'h74, 8'h22, 8'he7, 8'had, 8'h35, 8'h85, 8'he2, 8'hf9, 8'h37, 8'he8, 8'h1c, 8'h75, 8'hdf, 8'h6e,
        8'h47, 8'hf1, 8'h1a, 8'h71, 8'h1d, 8'h29, 8'hc5, 8'h89, 8'h6f, 8'hb7, 8'h62, 8'h0e, 8'haa, 8'h18, 8'hbe, 8'h1b,
        8'hfc, 8'h56, 8'h3e, 8'h4b, 8'hc6, 8'hd2, 8'h79, 8'h20, 8'h9a, 8'hdb, 8'hc0, 8'hfe, 8'h78, 8'hcd, 8'h5a, 8'hf4,
        8'h1f, 8'hdd, 8'ha8, 8'h33, 8'h88, 8'h07, 8'hc7, 8'h31, 8'hb1, 8'h12, 8'h10, 8'h59, 8'h27, 8'h80, 8'hec, 8'h5f,
        8'h60, 8'h51, 8'h7f, 8'ha9, 8'h19, 8'hb5, 8'h4a, 8'h0d, 8'h2d, 8'he5, 8'h7a, 8'h9f, 8'h93, 8'hc9, 8'h9c, 8'hef,
        8'ha0, 8'he0, 8'h3b, 8'h4d, 8'hae, 8'h2a, 8'hf5, 8'hb0, 8'hc8, 8'heb, 8'hbb, 8'h3c, 8'h83, 8'h53, 8'h99, 8'h61,
        8'h17, 8'h2b, 8'h04, 8'h7e, 8'hba, 8'h77, 8'hd6, 8'h26, 8'he1, 8'h69, 8'h14, 8'h63, 8'h55, 8'h21, 8'h0c, 8'h7d
    };

    static protected function tWORD subWord (tWORD win);
        return {
            sbox[win[31 -: 8]],
            sbox[win[23 -: 8]],
            sbox[win[15 -: 8]],
            sbox[win[7 -: 8]]
        };
    endfunction: subWord

    static protected function tWORD rotWord (tWORD win);
        return (win >> 24)|(win << 8);
    endfunction: rotWord

    static protected function tWORD rcon (int unsigned i);
        bit[7:0] tmp;
        tmp = 1;
        repeat(i-1) begin
            tmp = xtime(tmp);
        end
        return {tmp, 24'd0};
    endfunction

    static protected function void subBytes (ref bit[7:0] st[]);
        foreach(st[i]) 
            st[i] = sbox[st[i]];
    endfunction

    static protected function void invSubBytes (ref bit[7:0] st[]);
        foreach(st[i]) 
            st[i] = invSbox[st[i]];
    endfunction

    static protected function void shiftRows (ref bit[7:0] st[]);
        /* from     to
        st = {          st = {
            0 4 8 c         0 4 8 c
            1 5 9 d         5 9 d 1
            2 6 a e         a e 2 6
            3 7 b f         f 3 7 b
        };              };     */
        bit [7:0] tmp[];
        tmp = {
            st['h0], st['h5], st['ha], st['hf],
            st['h4], st['h9], st['he], st['h3],
            st['h8], st['hd], st['h2], st['h7],
            st['hc], st['h1], st['h6], st['hb]
        };
        st = tmp;
    endfunction

    static protected function void invShiftRows (ref bit[7:0] st[]);
        /* from         to    
        st = {                  st = {
            0 4 8 c                 0 4 8 c 
            1 5 9 d                 d 1 5 9 
            2 6 a e                 a e 2 6 
            3 7 b f                 7 b f 3 
        };                      }; */
        bit [7:0] tmp[];
        tmp = {
            st['h0], st['hd], st['ha], st['h7],
            st['h4], st['h1], st['he], st['hb],
            st['h8], st['h5], st['h2], st['hf],
            st['hc], st['h9], st['h6], st['h3]
        };
        st = tmp;
    endfunction

    static protected function void mixColumns (ref bit[7:0] st[]);
        bit [7:0] tmp[0:3];
        for (int c = 0; c < 4; c++) begin
            tmp[0] = GF8Mult(2, st[c*4+0])^GF8Mult(3, st[c*4+1])^st[c*4+2]^st[c*4+3];
            tmp[1] = st[c*4+0]^GF8Mult(2, st[c*4+1])^GF8Mult(3, st[c*4+2])^st[c*4+3];
            tmp[2] = st[c*4+0]^st[c*4+1]^GF8Mult(2, st[c*4+2])^GF8Mult(3, st[c*4+3]);
            tmp[3] = GF8Mult(3, st[c*4+0])^st[c*4+1]^st[c*4+2]^GF8Mult(2, st[c*4+3]);
            st[c*4+0] = tmp[0];
            st[c*4+1] = tmp[1];
            st[c*4+2] = tmp[2];
            st[c*4+3] = tmp[3];
        end
    endfunction

    static protected function void invMixColumns (ref bit[7:0] st[]);
    `define __mix(c0, c1, c2, c3) \
        GF8Mult(c0, st[c*4+0])^GF8Mult(c1, st[c*4+1])^GF8Mult(c2, st[c*4+2])^GF8Mult(c3, st[c*4+3])
        bit [7:0] tmp[0:3];
        for (int c = 0; c < 4; c++) begin
            tmp[0] = `__mix(8'h0e, 8'h0b, 8'h0d, 8'h09);
            tmp[1] = `__mix(8'h09, 8'h0e, 8'h0b, 8'h0d);
            tmp[2] = `__mix(8'h0d, 8'h09, 8'h0e, 8'h0b);
            tmp[3] = `__mix(8'h0b, 8'h0d, 8'h09, 8'h0e);
            st[c*4+0] = tmp[0];
            st[c*4+1] = tmp[1];
            st[c*4+2] = tmp[2];
            st[c*4+3] = tmp[3];
        end
    endfunction

endclass: RijndaelPreliminaries
`endif

