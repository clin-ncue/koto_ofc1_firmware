-------------------------------------------------------------------------------
-- Title      : Ethernet Common Package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : common.vhd
-- Author     : Ryan Thomas  <ryan@ryan-ThinkPad-T450s>
-- Company    : University of Chicago
-- Created    : 2019-08-21
-- Last update: 2019-10-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Package that includes some common types used accross multiple
-- components in the ethernet firmwaare.
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Ryan Thomas
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-08-21  1.0      ryan  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package eth_common is
  -------------------------------------------------------------------------------
  --Types and subtypes
  -------------------------------------------------------------------------------
  subtype word is std_logic_vector(31 downto 0);
  type data_array is array (integer range <>) of word;
  subtype in_fifo_usedw is std_logic_vector(10 downto 0);
  type in_fifo_usedw_array is array (integer range <>) of in_fifo_usedw;
  --Flag behavior: bit 0 is enable/disable, bit 1 is priority hi/normal
  subtype in_fifo_flag is std_logic_vector(1 downto 0);
  type in_fifo_flag_array is array (integer range <>) of in_fifo_flag;
  subtype mac_addr is std_logic_vector(47 downto 0);
  subtype ip_addr is std_logic_vector(31 downto 0);
  subtype udp_port is std_logic_vector(15 downto 0);
  type udp_port_array is array (integer range <>) of udp_port;
  subtype config_address is std_logic_vector(6 downto 0);
  type config_address_array is array(integer range <>) of config_address;
  -------------------------------------------------------------------------------
  -- Constants
  -------------------------------------------------------------------------------
  constant IN_FIFO_SIZE      : natural                       := 2048;
  constant N_IN_FIFOS        : natural                       := 5;
  constant IN_FIFO_BITS      : natural                       := 11;
  constant MAX_FRAME_BITS    : natural                       := 9;
  constant INFIFO_DISABLE    : in_fifo_flag                  := "00";
  constant INFIFO_ENABLE     : in_fifo_flag                  := "01";
  constant INFIFO_PRIORITY   : in_fifo_flag                  := "11";
  --Ethertypes
  constant ETH_IPv4          : std_logic_vector(15 downto 0) := X"08_00";
  constant ETH_ARP           : std_logic_vector(15 downto 0) := X"08_06";
  --IPv4 protocols
  constant PROTO_UDP         : std_logic_vector(7 downto 0)  := X"11";
  constant PROTO_ICMP        : std_logic_vector(7 downto 0)  := X"01";
  --ARP packet types
  constant ARP_REQUEST       : std_logic_vector(15 downto 0) := X"00_01";
  constant ARP_REPLY         : std_logic_vector(15 downto 0) := X"00_02";
  --ICMP types
  constant ICMP_ECHO_REQUEST : std_logic_vector(15 downto 0) := X"08_00";
  constant ICMP_ECHO_REPLY   : std_logic_vector(15 downto 0) := X"00_00";
  --UDP ports
  constant UDP_PORT_CONFIG   : udp_port                      := X"4268";
  constant UDP_PORT_BASES : udp_port_array(2 downto 0) := (0 => X"1000",
                                                           1 => X"1100",
                                                           2 => X"1200");
  constant UDP_PORT_LOOPBACKS : udp_port_array(2 downto 0) := (0 => UDP_PORT_BASES(0) or X"0004",
                                                               1 => UDP_PORT_BASES(1) or X"0004",
                                                               2 => UDP_PORT_BASES(2) or X"0004");
  --Configuration block addresses (note: these match the base UDP port
  --addresses above, if you change these please change above to match)
  constant ENET_CONFIG_ADDRESSES : config_address_array(2 downto 0) := (0 => "0010000",
                                                                        1 => "0010001",
                                                                        2 => "0010010");
  -------------------------------------------------------------------------------
  -- Functions
  -------------------------------------------------------------------------------
  -- Computes number of bits needed to represent a number
  function f_num_bits (x : natural) return natural;

end eth_common;

package body eth_common is


  function f_num_bits (x : natural) return natural is
  begin  -- function f_num_bits
    return integer(ceil(log2(real(x))));
  end function f_num_bits;

end eth_common;


