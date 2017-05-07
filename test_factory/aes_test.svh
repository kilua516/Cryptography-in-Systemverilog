//
//File: aes_test.svh
//Device: 
//Created:  2017-5-7 20:26:26
//Description: aes tests
//Revisions: 
//2017-5-7 20:26:36: created
//

`ifndef __AES_TEST_SVH
`define __AES_TEST_SVH

class aes_test extends TestPrototype;
    `__register(aes_test)

    task test ();
        bit[7:0] dout[], din[], key[];
        aes_pkg::AES128 aes_128;
        aes_pkg::AES192 aes_192;
        aes_pkg::AES256 aes_256;
        aes_128 = new();
        aes_192 = new();
        aes_256 = new();
        aes_128.setLogging();
        aes_192.setLogging();
        aes_256.setLogging();

        //key = '{8'h2b, 8'h7e, 8'h15, 8'h16, 8'h28, 8'hae, 8'hd2, 8'ha6, 8'hab, 8'hf7, 8'h15, 8'h88, 8'h09, 8'hcf, 8'h4f, 8'h3c};
        //din = '{8'h32, 8'h43, 8'hf6, 8'ha8, 8'h88, 8'h5a, 8'h30, 8'h8d, 8'h31, 8'h31, 8'h98, 8'ha2, 8'he0, 8'h37, 8'h07, 8'h34};
        //aes_128.setKey(key);
        //aes_128.encrypt(din, dout);
        //key = '{ 8'h8e, 8'h73, 8'hb0, 8'hf7, 8'hda, 8'h0e, 8'h64, 8'h52, 8'hc8, 8'h10, 8'hf3, 8'h2b, 8'h80, 8'h90, 8'h79, 8'he5, 8'h62, 8'hf8, 8'hea, 8'hd2, 8'h52, 8'h2c, 8'h6b, 8'h7b };
        //din = '{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        //aes_192.setKey(key);
        //aes_192.encrypt(din, dout);

        //key = '{ 8'h60, 8'h3d, 8'heb, 8'h10, 8'h15, 8'hca, 8'h71, 8'hbe, 8'h2b, 8'h73, 8'hae, 8'hf0, 8'h85, 8'h7d, 8'h77, 8'h81, 8'h1f, 8'h35, 8'h2c, 8'h07, 8'h3b, 8'h61, 8'h08, 8'hd7, 8'h2d, 8'h98, 8'h10, 8'ha3, 8'h09, 8'h14, 8'hdf, 8'hf4 };
        //aes_256.setKey(key);
        //aes_256.encrypt(din, dout);

        din = {>>byte{128'h00112233445566778899aabbccddeeff}};
        key = {>>byte{128'h000102030405060708090a0b0c0d0e0f}};
        aes_128.setKey(key);
        aes_128.encrypt(din, dout);
        din = {>>byte{128'h69c4e0d86a7b0430d8cdb78070b4c55a}};
        aes_128.decrypt(din, dout);

        din = {>>byte{128'h00112233445566778899aabbccddeeff}};
        key = {>>byte{192'h000102030405060708090a0b0c0d0e0f1011121314151617}};
        aes_192.setKey(key);
        aes_192.encrypt(din, dout);
        din = {>>byte{128'hdda97ca4864cdfe06eaf70a0ec0d7191}};
        aes_192.decrypt(din, dout);

        din = {>>byte{128'h00112233445566778899aabbccddeeff}};
        key = {>>byte{256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f}};
        aes_256.setKey(key);
        aes_256.encrypt(din, dout);
        din = {>>byte{128'h8ea2b7ca516745bfeafc49904b496089}};
        aes_256.decrypt(din, dout);

    endtask

endclass: aes_test

`endif

