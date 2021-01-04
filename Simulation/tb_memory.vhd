----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2021 12:46:25
-- Design Name: 
-- Module Name: tb_memory - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity tb_memory is
--  Port ( );
end tb_memory;

architecture Behavioral of tb_memory is
component Block_memory is 
Port (
clk : in std_logic; 
wr  : in std_logic;
addr : in std_logic_vector(11 downto 0);
data_in : in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0)
 );
end component;
signal clk: std_logic :='0';
signal wr: std_logic :='0';
signal addr: std_logic_vector(11 downto 0):="000000000000";
signal data_in: std_logic_vector(7 downto 0) := X"00";
signal data_out: std_logic_vector(7 downto 0);
signal count: integer range 0 to 200 := 0;
begin
mem1: Block_memory port map(clk=>clk,wr=>wr,addr=>addr,data_in=>data_in,data_out=>data_out); 
process 
begin
clk <= '1';
wait for 5 ns;
clk <= '0';
wait for 5 ns;
end process;

p2: process(clk)
begin
if(rising_edge(clk)) then
if(count <= 50) then
    wr <= '1';
    addr <= std_logic_vector(TO_UNSIGNED(count,addr'length));
    data_in <= std_logic_vector(TO_UNSIGNED(count,data_in'length));
    count <= count + 1;
 elsif(count>50 and count<=100) then
    count <= count +1;
    wr  <= '0';
    addr <= std_logic_vector(TO_UNSIGNED((count-50),addr'length));
 elsif(count > 100) then
    count <= 0;
 end if;
 end if;
 end process p2;
end Behavioral;
