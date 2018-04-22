//
//File: des_pkg.sv
//Device: 
//Created:  2017-4-9 16:01:19
//Description: des package
//Revisions: 
//2017-4-9 16:01:28: created
//

package des_pkg;
    `include "base_macros.svh"
    import base_pkg::LogBase;
    `include "DESPreliminaries.svh"
    `include "CoreDES.svh"
    `include "CoreTDEA.svh"
    `include "DESByteWrapper.svh"
    typedef DESByteWrapper#(CoreDES) ByteDES;
    typedef DESByteWrapper#(CoreTDEA) ByteTDEA;
endpackage

