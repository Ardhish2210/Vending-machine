// The below code if for a VENDING MACHINE with only 1 product in it, the price of the product is 15Rs....

module vending_machine (clk, rst, in, out, change);

input clk, rst;
input [1:0] in; // 00: 0rs, 01: 5Rs, 10: 10Rs
output reg out;
output reg [1:0] change;

reg [1:0] c_state, n_state;

parameter S0 = 2'b00; // 0Rs
parameter S1 = 2'b01; // 5Rs
parameter S2 = 2'b10; // 10Rs

always @(posedge clk or posedge rst) begin
    if(rst) begin
        c_state <= S0;
        out <= 1'b0;
        change <= 2'b00;
    end else begin

        c_state <= n_state;
        
        case (c_state)
        S0: begin
            if (in == 2'b00) begin
                out <= 1'b0;
                change <= 2'b00;
            end else if (in == 2'b01) begin
                out <= 1'b0;
                change <= 2'b00;
            end else if (in == 2'b10) begin
                out <= 1'b0;
                change <= 2'b00;
            end
        end

        S1: begin
            if (in == 2'b00) begin
                out <= 1'b0;
                change <= 2'b01;  
            end else if (in == 2'b01) begin
                out <= 1'b0;
                change <= 2'b00;
            end else if (in == 2'b10) begin
                out <= 1'b1;      
                change <= 2'b00;
            end
        end
        
        S2: begin
            if (in == 2'b00) begin
                out <= 1'b0;
                change <= 2'b10;  
            end else if (in == 2'b01) begin
                out <= 1'b1;      
                change <= 2'b00;
            end else if (in == 2'b10) begin
                out <= 1'b1;      
                change <= 2'b01;  
            end
        end
        endcase
    end
end

always @(*) begin
    
    n_state = c_state;
    
    case (c_state)
    S0: begin
        if (in == 2'b00) begin
            n_state = S0;
        end else if (in == 2'b01) begin
            n_state = S1;
        end else if (in == 2'b10) begin
            n_state = S2;
        end
    end

    S1: begin
        if (in == 2'b00) begin
            n_state = S0;
        end else if (in == 2'b01) begin
            n_state = S2;
        end else if (in == 2'b10) begin
            n_state = S0;
        end
    end
    
    S2: begin
        if (in == 2'b00) begin
            n_state = S0;
        end else if (in == 2'b01) begin
            n_state = S0;
        end else if (in == 2'b10) begin
            n_state = S0;
        end
    end
    
    default: begin
        n_state = S0;
    end
    endcase
end

endmodule