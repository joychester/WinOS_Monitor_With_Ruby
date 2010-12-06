# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'perf_mon_util'

case ARGV.length

when 0

  puts "Please assign monitored machines' name, you can access help by type Perf_mon_runner.rb -help"
  puts "Process exiting..."
  Process.exit!(1);

when 1
  if ARGV[0] == "-help"
    puts "usage samples listed: Perf_mon_runner.rb MonitredIPs Duration Interval FilePath"
    puts "Perf_mon_runner.rb \"ip1,ip2,ip3\" 1 20 \"D:\\\\temp\\\\\""
    puts "Monitoring object list(Measurements including):"
    puts "  \\processor(_total)\\% processor time"
    puts "  \\processor(_total)\\% user time"
    puts "  \\processor(_total)\\% privileged time"
    puts "  \\Memory\\Available Kbytes"
    puts "  \\physicaldisk(_total)\\% disk read time"
    puts "  \\physicaldisk(_total)\\% disk write time"
    puts "  \\network interface(*#1)\\bytes total/sec"
    Process.exit!(1);
  end

  puts "put your monitoring files in C:\\temp_mon\\"
  CPU_Utilization= PerfMonUtil.new(ARGV[0]);
  CPU_Utilization.perfmon();

when 2
  puts "put your monitoring files in C:\\temp_mon\\"
  CPU_Utilization= PerfMonUtil.new(ARGV[0]);
  CPU_Utilization.perfmon(ARGV[1]);

when 3
  puts "put your monitoring files in C:\\temp_mon\\"
  CPU_Utilization= PerfMonUtil.new(ARGV[0]);
  CPU_Utilization.perfmon(ARGV[1],ARGV[2]);

when 4
  puts "put your monitoring files in " + ARGV[3]
  CPU_Utilization= PerfMonUtil.new(ARGV[0]);
  CPU_Utilization.perfmon(ARGV[1],ARGV[2],ARGV[3]);
  
end
