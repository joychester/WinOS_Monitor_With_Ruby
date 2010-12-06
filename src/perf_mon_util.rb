# To change this template, choose Tools | Templates
# and open the template in the editor.


class PerfMonUtil
  @hostIPs = [];

  def initialize(hostarray)
    hostarray = hostarray.sub(/\s/, '');
    @hostIPs = hostarray.split(',');
    
    puts "monitor IP(s): " + @hostIPs * ",";
  end

  # the unit of duration is set to minutes by default
  def perfmon(duration = 5,intv = 1, filepath = "C:\\temp_mon\\")

    puts @hostIPs;
    puts intv;

    sampler_count = (duration.to_i * 60) / intv.to_i;

    @hostIPs.each { |inputIP|

      machineIP = inputIP.strip;
      filename = filepath + machineIP.gsub(/\./,'_') + "-" + Time.now.strftime("%Y%m%d-%H%M%S");

      Thread.new {

              system("typeperf",
              "\\processor(_total)\\% processor time", #CPU%
              "\\processor(_total)\\% user time",
              "\\processor(_total)\\% privileged time",
              "\\Memory\\Available Kbytes", #MEM_Utilization
              "\\physicaldisk(_total)\\% disk read time", #DISK I/O
              "\\physicaldisk(_total)\\% disk write time",
              "\\network interface(*#1)\\bytes total/sec", #NetWork I/O
              "-s", "#{machineIP}","-si","#{intv}", "-sc", "#{sampler_count}", "-o", filename)

              Process.exit!(1);
       }
    }
    
  end
end


