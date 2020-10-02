LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;
entity Assignment6 is
port(C: in std_logic;
			 D : in std_logic_vector(3 downto 0);
			 mode : in std_logic;
			 LED : out std_logic_vector(15 downto 0);
				
          A    : out   std_logic_vector(3 downto 0);  
          cathode : out std_logic_vector(0 to 6));
end Assignment6;

architecture Behavioral of Assignment6 is
signal flag : std_logic;
signal counter_clk : std_logic;
signal pwm_clk : std_logic;
signal tmp : std_logic_vector(3 downto 0);
signal t : std_logic_vector(3 downto 0);
signal output : std_logic;
signal m : integer range 0 to 100000 := 0;
signal n : integer range 0 to 100000000 := 0;
begin
process (C) 
    begin
        if (C'event and C='1') then
            m <= m + 1;
			n <= n+1;
        end if;
       
        if (m=100000) then
            m <= 0;
        end if;
       
        if (m<50000) then
            counter_clk <= '1';
        else
            counter_clk <= '0';
        end if;
		  
		  if (n=100000000) then
            n <= 0;
        end if;
       
        if (n<50000000) then
            pwm_clk <= '1';
        else
            pwm_clk <= '0';
        end if;
    end process;

process (C)
    begin
    if (C'event and C='1') then
    if( n=99999999 ) then
	   if (flag ='0') then
		
		tmp <= tmp + 1;
		     if(to_integer(unsigned(tmp))=14) then
		      flag <= '1';
		      end if;
	   else

		tmp <= tmp - 1;
			if(to_integer(unsigned(tmp))=1) then
                      flag <= '0';
                      end if;
		end if;
	end if;
end if;
end process;

process (C)
begin
if (C'event and C='1') then
	if( m=99999) then
		if(mode='0') then
			CASE D IS
                            WHEN "0000" => cathode <="0000001";
                            WHEN "0001" => cathode <="1001111";
                            WHEN "0010" => cathode <="0010010";
                            WHEN "0011" => cathode <="0000110";
                            WHEN "0100" => cathode <="1001100";
                            WHEN "0101" => cathode <="0100100";
                            WHEN "0110" => cathode <="0100000";
                            WHEN "0111" => cathode <="0001111";
                            WHEN "1000" => cathode <="0000000";
                            WHEN "1001" => cathode <="0000100";
                            WHEN "1010" => cathode <="0001000";
                            WHEN "1011" => cathode <="1100000";
                            WHEN "1100" => cathode <="0110001";
                            WHEN "1101" => cathode <="1000010";
                            WHEN "1110" => cathode <="0110000";
                            WHEN "1111" => cathode <="0111000";
			END CASE;

			if(to_integer(unsigned(t)) < to_integer(unsigned(D)) ) then
				output <= '1';
			else
				output <= '0';
			end if;
		else
			CASE tmp IS
                            WHEN "0000" => cathode <="0000001";
                            WHEN "0001" => cathode <="1001111";
                            WHEN "0010" => cathode <="0010010";
                            WHEN "0011" => cathode <="0000110";
                            WHEN "0100" => cathode <="1001100";
                            WHEN "0101" => cathode <="0100100";
                            WHEN "0110" => cathode <="0100000";
                            WHEN "0111" => cathode <="0001111";
                            WHEN "1000" => cathode <="0000000";
                            WHEN "1001" => cathode <="0000100";
                            WHEN "1010" => cathode <="0001000";
                            WHEN "1011" => cathode <="1100000";
                            WHEN "1100" => cathode <="0110001";
                            WHEN "1101" => cathode <="1000010";
                            WHEN "1110" => cathode <="0110000";
                            WHEN "1111" => cathode <="0111000";
			END CASE;
			if(to_integer(unsigned(t)) < to_integer(unsigned(tmp))) then
				output <= '1';
			else
				output <= '0';
			end if;
		end if;
		t <= t + 1;
	end if;
end if;
if(output ='0') then
	LED <= "0000000000000000";
else
	LED <= "1111111111111111";
A(0) <= '0';
A(1) <= '1';
A(2) <= '1';
A(3) <= '1';

end if;
end process;

 

end Behavioral;
