------------------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz    : std_logic;
    --- WRITE YOUR CODE HERE
    signal s_reset         : std_logic;
    signal s_data0         : std_logic_vector(4 - 1 downto 0);
    signal s_data1         : std_logic_vector(4 - 1 downto 0);
    signal s_data2         : std_logic_vector(4 - 1 downto 0);
    signal s_data3         : std_logic_vector(4 - 1 downto 0);
    
    signal s_dp_i          : std_logic_vector(4 - 1 downto 0);
    signal s_dp_o          : std_logic;
    signal s_seg           : std_logic_vector(7 - 1 downto 0);
    
    signal s_dig           : std_logic_vector(4 - 1 downto 0);

begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
        port map(
            clk      => s_clk_100MHz,
            reset    => s_reset,
            
            data0_i  => s_data0,
            data1_i  => s_data1,
            data2_i  => s_data2,
            data3_i  => s_data3,
            
            dp_i     => s_dp_i,
            
            dp_o     => s_dp_o,
            
            seg_o    => s_seg,
            
            dig_o    => s_dig
        );
    
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 40 ms loop        
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE


     p_reset_gen : process
        begin
            s_reset <= '0';
            wait for 28 ns;
            
            -- Reset activated
            s_reset <= '1';
            wait for 53 ns;
    
            --Reset deactivated
            s_reset <= '0';
            
            --wait for 700 ns;
            --s_reset <= '1';
    
            wait;
     end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        -- 3.142
        s_data3 <= "0011";
        s_data2 <= "0001";
        s_data1 <= "0100";
        s_data0 <= "0010";
               
        s_dp_i  <= "0111";
        
        wait for 6 ms;
        
        assert ((s_dig = "0111") and (s_seg = "0000110") and (s_dp_o = '0'))
        report "Test failed for input: '3.' " severity error;
        
        wait for 4 ms;
        
        assert ((s_dig = "1011") and (s_seg = "1001111") and (s_dp_o = '1'))
        report "Test failed for input: '1' " severity error;
        
        wait for 4 ms;
        
        assert ((s_dig = "1101") and (s_seg = "1001100") and (s_dp_o = '1'))
        report "Test failed for input: '4' " severity error;
        
        wait for 4 ms;
        
        assert ((s_dig = "1110") and (s_seg = "0010010") and (s_dp_o = '1'))
        report "Test failed for input: '2' " severity error;
        
        
    
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    

end architecture testbench;
