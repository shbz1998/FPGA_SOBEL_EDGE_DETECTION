
LIBRARY IEEE;

USE IEEE.std_logic_textio.ALL;
USE IEEE.std_logic_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;

USE STD.textio.ALL;
LIBRARY work;
USE work.sobel_edge_detection_fixpt_pkg.ALL;
USE work.sobel_edge_detection_fixpt_tb_pkg.ALL;

ENTITY sobel_edge_detection_fixpt_tb IS
END sobel_edge_detection_fixpt_tb;


ARCHITECTURE rtl OF sobel_edge_detection_fixpt_tb IS

  -- Component Declarations
  COMPONENT sobel_edge_detection_fixpt
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          x_in                            :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          y_in                            :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix9
          data_in1                        :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          ce_out                          :   OUT   std_logic;
          x_out                           :   OUT   std_logic_vector(10 DOWNTO 0);  -- ufix11
          y_out                           :   OUT   std_logic_vector(10 DOWNTO 0);  -- ufix11
          data_out                        :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : sobel_edge_detection_fixpt
    USE ENTITY work.sobel_edge_detection_fixpt(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL data_out_done                    : std_logic;  -- ufix1
  SIGNAL rdEnb                            : std_logic;
  SIGNAL data_out_done_enb                : std_logic;  -- ufix1
  SIGNAL x_out_addr                       : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL data_out_lastAddr                : std_logic;  -- ufix1
  SIGNAL resetn                           : std_logic;
  SIGNAL check3_done                      : std_logic;  -- ufix1
  SIGNAL y_out_done                       : std_logic;  -- ufix1
  SIGNAL y_out_done_enb                   : std_logic;  -- ufix1
  SIGNAL y_out_lastAddr                   : std_logic;  -- ufix1
  SIGNAL check2_done                      : std_logic;  -- ufix1
  SIGNAL x_out_done                       : std_logic;  -- ufix1
  SIGNAL x_out_done_enb                   : std_logic;  -- ufix1
  SIGNAL x_out_active                     : std_logic;  -- ufix1
  SIGNAL x_in_addr                        : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL data_in1_addr_delay_1            : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL tb_enb                           : std_logic;
  SIGNAL rawData_data_in1                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL holdData_data_in1                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_in1_offset                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_in1                         : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_in1_1                       : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL y_in_addr_delay_1                : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rawData_y_in                     : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL holdData_y_in                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL y_in_offset                      : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL y_in                             : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL y_in_1                           : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL x_in_active                      : std_logic;  -- ufix1
  SIGNAL x_in_enb                         : std_logic;  -- ufix1
  SIGNAL x_in_addr_delay_1                : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL rawData_x_in                     : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL holdData_x_in                    : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL x_in_offset                      : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL x_in_1                           : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL x_in_2                           : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL snkDone                          : std_logic;
  SIGNAL snkDonen                         : std_logic;
  SIGNAL ce_out                           : std_logic;
  SIGNAL x_out                            : std_logic_vector(10 DOWNTO 0);  -- ufix11
  SIGNAL y_out                            : std_logic_vector(10 DOWNTO 0);  -- ufix11
  SIGNAL data_out                         : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL x_out_enb                        : std_logic;  -- ufix1
  SIGNAL x_out_lastAddr                   : std_logic;  -- ufix1
  SIGNAL check1_done                      : std_logic;  -- ufix1
  SIGNAL x_out_chkcnt                     : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL x_out_ignCntDone                 : std_logic;  -- ufix1
  SIGNAL x_out_needToCount                : std_logic;  -- ufix1
  SIGNAL x_out_chkenb                     : std_logic;  -- ufix1
  SIGNAL x_out_chkdata                    : std_logic;  -- ufix1
  SIGNAL x_out_addr_delay_1               : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL x_out_unsigned                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL x_out_expected                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL x_out_ref                        : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL x_out_testFailure                : std_logic;  -- ufix1
  SIGNAL y_out_chkcnt                     : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL y_out_ignCntDone                 : std_logic;  -- ufix1
  SIGNAL y_out_needToCount                : std_logic;  -- ufix1
  SIGNAL y_out_chkenb                     : std_logic;  -- ufix1
  SIGNAL y_out_chkdata                    : std_logic;  -- ufix1
  SIGNAL y_out_addr_delay_1               : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL y_out_unsigned                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL y_out_expected                   : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL y_out_ref                        : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL y_out_testFailure                : std_logic;  -- ufix1
  SIGNAL data_out_chkcnt                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL data_out_ignCntDone              : std_logic;  -- ufix1
  SIGNAL data_out_needToCount             : std_logic;  -- ufix1
  SIGNAL data_out_chkenb                  : std_logic;  -- ufix1
  SIGNAL data_out_chkdata                 : std_logic;  -- ufix1
  SIGNAL data_out_addr_delay_1            : unsigned(18 DOWNTO 0);  -- ufix19
  SIGNAL data_out_unsigned                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_out_expected                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_out_ref                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL data_out_testFailure             : std_logic;  -- ufix1
  SIGNAL testFailure                      : std_logic;  -- ufix1

BEGIN
  u_sobel_edge_detection_fixpt : sobel_edge_detection_fixpt
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => enb,
              x_in => x_in_2,  -- ufix9
              y_in => y_in_1,  -- ufix9
              data_in1 => data_in1_1,  -- uint8
              ce_out => ce_out,
              x_out => x_out,  -- ufix11
              y_out => y_out,  -- ufix11
              data_out => data_out  -- uint8
              );

  data_out_done_enb <= data_out_done AND rdEnb;

  
  data_out_lastAddr <= '1' WHEN x_out_addr >= to_unsigned(16#40002#, 19) ELSE
      '0';

  data_out_done <= data_out_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_3_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check3_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF data_out_done_enb = '1' THEN
        check3_done <= data_out_done;
      END IF;
    END IF;
  END PROCESS checkDone_3_process;

  y_out_done_enb <= y_out_done AND rdEnb;

  
  y_out_lastAddr <= '1' WHEN x_out_addr >= to_unsigned(16#40002#, 19) ELSE
      '0';

  y_out_done <= y_out_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_2_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check2_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF y_out_done_enb = '1' THEN
        check2_done <= y_out_done;
      END IF;
    END IF;
  END PROCESS checkDone_2_process;

  x_out_done_enb <= x_out_done AND rdEnb;

  
  x_out_active <= '1' WHEN x_out_addr /= to_unsigned(16#40002#, 19) ELSE
      '0';

  data_in1_addr_delay_1 <= x_in_addr AFTER 1 ns;

  -- Data source for data_in1
  data_in1_fileread: PROCESS (data_in1_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "LENNA_IN.txt";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_data_in1 <= unsigned(read_data(7 DOWNTO 0));
  END PROCESS data_in1_fileread;

  -- holdData reg for data_in1
  stimuli_data_in1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_data_in1 <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_data_in1 <= rawData_data_in1;
    END IF;
  END PROCESS stimuli_data_in1_process;

  stimuli_data_in1_1: PROCESS (rawData_data_in1, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      data_in1_offset <= holdData_data_in1;
    ELSE
      data_in1_offset <= rawData_data_in1;
    END IF;
  END PROCESS stimuli_data_in1_1;

  data_in1 <= data_in1_offset AFTER 2 ns;

  data_in1_1 <= std_logic_vector(data_in1);

  y_in_addr_delay_1 <= x_in_addr AFTER 1 ns;

  -- Data source for y_in
  y_in_fileread: PROCESS (y_in_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "y_in.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(11 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_y_in <= unsigned(read_data(8 DOWNTO 0));
  END PROCESS y_in_fileread;

  -- holdData reg for y_in
  stimuli_y_in_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_y_in <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_y_in <= rawData_y_in;
    END IF;
  END PROCESS stimuli_y_in_process;

  stimuli_y_in_1: PROCESS (rawData_y_in, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      y_in_offset <= holdData_y_in;
    ELSE
      y_in_offset <= rawData_y_in;
    END IF;
  END PROCESS stimuli_y_in_1;

  y_in <= y_in_offset AFTER 2 ns;

  y_in_1 <= std_logic_vector(y_in);

  
  x_in_active <= '1' WHEN x_in_addr /= to_unsigned(16#40008#, 19) ELSE
      '0';

  x_in_enb <= x_in_active AND (rdEnb AND tb_enb);

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 262152
  x_in_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_in_addr <= to_unsigned(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF x_in_enb = '1' THEN
        IF x_in_addr >= to_unsigned(16#40008#, 19) THEN 
          x_in_addr <= to_unsigned(16#00000#, 19);
        ELSE 
          x_in_addr <= x_in_addr + to_unsigned(16#00001#, 19);
        END IF;
      END IF;
    END IF;
  END PROCESS x_in_process;


  x_in_addr_delay_1 <= x_in_addr AFTER 1 ns;

  -- Data source for x_in
  x_in_fileread: PROCESS (x_in_addr_delay_1, tb_enb, rdEnb)
    FILE fp: TEXT open READ_MODE is "x_in.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(11 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF rdEnb = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    rawData_x_in <= unsigned(read_data(8 DOWNTO 0));
  END PROCESS x_in_fileread;

  -- holdData reg for x_in
  stimuli_x_in_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      holdData_x_in <= (OTHERS => 'X');
    ELSIF clk'event AND clk = '1' THEN
      holdData_x_in <= rawData_x_in;
    END IF;
  END PROCESS stimuli_x_in_process;

  stimuli_x_in_1: PROCESS (rawData_x_in, rdEnb)
  BEGIN
    IF rdEnb = '0' THEN
      x_in_offset <= holdData_x_in;
    ELSE
      x_in_offset <= rawData_x_in;
    END IF;
  END PROCESS stimuli_x_in_1;

  x_in_1 <= x_in_offset AFTER 2 ns;

  x_in_2 <= std_logic_vector(x_in_1);

  snkDonen <=  NOT snkDone;

  resetn <=  NOT reset;

  tb_enb <= resetn AND snkDonen;

  
  rdEnb <= tb_enb WHEN snkDone = '0' ELSE
      '0';

  enb <= rdEnb AFTER 2 ns;

  reset_gen: PROCESS 
  BEGIN
    reset <= '1';
    WAIT FOR 20 ns;
    WAIT UNTIL clk'event AND clk = '1';
    WAIT FOR 2 ns;
    reset <= '0';
    WAIT;
  END PROCESS reset_gen;

  clk_gen: PROCESS 
  BEGIN
    clk <= '1';
    WAIT FOR 5 ns;
    clk <= '0';
    WAIT FOR 5 ns;
    IF snkDone = '1' THEN
      clk <= '1';
      WAIT FOR 5 ns;
      clk <= '0';
      WAIT FOR 5 ns;
      WAIT;
    END IF;
  END PROCESS clk_gen;

  x_out_enb <= ce_out AND x_out_active;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 262146
  x_out_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_out_addr <= to_unsigned(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF x_out_enb = '1' THEN
        IF x_out_addr >= to_unsigned(16#40002#, 19) THEN 
          x_out_addr <= to_unsigned(16#00000#, 19);
        ELSE 
          x_out_addr <= x_out_addr + to_unsigned(16#00001#, 19);
        END IF;
      END IF;
    END IF;
  END PROCESS x_out_1_process;


  
  x_out_lastAddr <= '1' WHEN x_out_addr >= to_unsigned(16#40002#, 19) ELSE
      '0';

  x_out_done <= x_out_lastAddr AND resetn;

  -- Delay to allow last sim cycle to complete
  checkDone_1_process: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      check1_done <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF x_out_done_enb = '1' THEN
        check1_done <= x_out_done;
      END IF;
    END IF;
  END PROCESS checkDone_1_process;

  snkDone <= check3_done AND (check1_done AND check2_done);

  
  x_out_ignCntDone <= '1' WHEN x_out_chkcnt /= to_unsigned(16#3#, 2) ELSE
      '0';

  x_out_needToCount <= ce_out AND x_out_ignCntDone;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 3
  x_out_IgnoreDataChecking_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_out_chkcnt <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF x_out_needToCount = '1' THEN
        x_out_chkcnt <= x_out_chkcnt + to_unsigned(16#1#, 2);
      END IF;
    END IF;
  END PROCESS x_out_IgnoreDataChecking_process;


  
  x_out_chkenb <= '1' WHEN x_out_chkcnt = to_unsigned(16#3#, 2) ELSE
      '0';

  x_out_chkdata <= ce_out AND x_out_chkenb;

  x_out_addr_delay_1 <= x_out_addr AFTER 1 ns;

  x_out_unsigned <= unsigned(x_out);

  -- Data source for x_out_expected
  x_out_expected_fileread: PROCESS (x_out_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "x_out_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(11 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    x_out_expected <= unsigned(read_data(10 DOWNTO 0));
  END PROCESS x_out_expected_fileread;

  x_out_ref <= x_out_expected;

  x_out_unsigned_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      x_out_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF x_out_chkdata = '1' AND x_out_unsigned /= x_out_ref THEN
        x_out_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in x_out_unsigned: Expected " & to_hex(x_out_ref) & (" Actual " & to_hex(x_out_unsigned))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS x_out_unsigned_checker;

  
  y_out_ignCntDone <= '1' WHEN y_out_chkcnt /= to_unsigned(16#3#, 2) ELSE
      '0';

  y_out_needToCount <= ce_out AND y_out_ignCntDone;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 3
  y_out_IgnoreDataChecking_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_out_chkcnt <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF y_out_needToCount = '1' THEN
        y_out_chkcnt <= y_out_chkcnt + to_unsigned(16#1#, 2);
      END IF;
    END IF;
  END PROCESS y_out_IgnoreDataChecking_process;


  
  y_out_chkenb <= '1' WHEN y_out_chkcnt = to_unsigned(16#3#, 2) ELSE
      '0';

  y_out_chkdata <= ce_out AND y_out_chkenb;

  y_out_addr_delay_1 <= x_out_addr AFTER 1 ns;

  y_out_unsigned <= unsigned(y_out);

  -- Data source for y_out_expected
  y_out_expected_fileread: PROCESS (y_out_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "y_out_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(11 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    y_out_expected <= unsigned(read_data(10 DOWNTO 0));
  END PROCESS y_out_expected_fileread;

  y_out_ref <= y_out_expected;

  y_out_unsigned_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      y_out_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF y_out_chkdata = '1' AND y_out_unsigned /= y_out_ref THEN
        y_out_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in y_out_unsigned: Expected " & to_hex(y_out_ref) & (" Actual " & to_hex(y_out_unsigned))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS y_out_unsigned_checker;

  
  data_out_ignCntDone <= '1' WHEN data_out_chkcnt /= to_unsigned(16#3#, 2) ELSE
      '0';

  data_out_needToCount <= ce_out AND data_out_ignCntDone;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 3
  data_out_IgnoreDataChecking_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_out_chkcnt <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF data_out_needToCount = '1' THEN
        data_out_chkcnt <= data_out_chkcnt + to_unsigned(16#1#, 2);
      END IF;
    END IF;
  END PROCESS data_out_IgnoreDataChecking_process;


  
  data_out_chkenb <= '1' WHEN data_out_chkcnt = to_unsigned(16#3#, 2) ELSE
      '0';

  data_out_chkdata <= ce_out AND data_out_chkenb;

  data_out_addr_delay_1 <= x_out_addr AFTER 1 ns;

  data_out_unsigned <= unsigned(data_out);

  -- Data source for data_out_expected
  data_out_expected_fileread: PROCESS (data_out_addr_delay_1, tb_enb, ce_out)
    FILE fp: TEXT open READ_MODE is "data_out_expected.dat";
    VARIABLE l: LINE;
    VARIABLE read_data: std_logic_vector(7 DOWNTO 0);

  BEGIN
    IF tb_enb /= '1' THEN
    ELSIF ce_out = '1' AND NOT ENDFILE(fp) THEN
      READLINE(fp, l);
      HREAD(l, read_data);
    END IF;
    data_out_expected <= unsigned(read_data(7 DOWNTO 0));
  END PROCESS data_out_expected_fileread;

  data_out_ref <= data_out_expected;
  
 process(clk)
 variable row : line;
 file test_vector      : text open write_mode is "LENNA_OUTPUT_SOBEL8.txt";
 begin
 if rising_edge(clk) then
     write(row,conv_integer(data_out));
     writeline(test_vector,row);
 end if;
 
 end process;

  data_out_unsigned_checker: PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_out_testFailure <= '0';
    ELSIF clk'event AND clk = '1' THEN
      IF data_out_chkdata = '1' AND data_out_unsigned /= data_out_ref THEN
        data_out_testFailure <= '1';
        ASSERT FALSE
          REPORT "Error in data_out_unsigned: Expected " & to_hex(data_out_ref) & (" Actual " & to_hex(data_out_unsigned))
          SEVERITY ERROR;
      END IF;
    END IF;
  END PROCESS data_out_unsigned_checker;

--  testFailure <= data_out_testFailure OR (x_out_testFailure OR y_out_testFailure);

--  completed_msg: PROCESS (clk)
--  BEGIN
--    IF clk'event AND clk = '1' THEN
--      IF snkDone = '1' THEN
--        IF testFailure = '0' THEN
--          ASSERT FALSE
--            REPORT "**************TEST COMPLETED (PASSED)**************"
--            SEVERITY NOTE;
--        ELSE
--          ASSERT FALSE
--            REPORT "**************TEST COMPLETED (FAILED)**************"
--            SEVERITY NOTE;
--        END IF;
--      END IF;
--    END IF;
--  END PROCESS completed_msg;

END rtl;

