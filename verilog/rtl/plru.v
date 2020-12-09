module plru_1(clk, rst, acc, acc_en, lru);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input acc;
  input acc_en;
  input clk;
  output lru;
  input rst;
  reg [1:0] tree;
  assign _0_ = ~ acc;
  assign _1_ = acc_en ? _0_ : tree[1];
  assign _2_ = rst ? 1'h0 : tree[0];
  assign _3_ = rst ? 1'h0 : _1_;
  always @(posedge clk)
    tree <= { _3_, _2_ };
  assign lru = tree[1];
endmodule
