require 'csv'
require 'gruff'

def parserperfmon(csvfile, targetfile)
  arraycpu = Array.new;
  arraymem = Array.new;
  arrayread = Array.new;
  arraywrite = Array.new;
  arraytcpconn = Array.new;
  
  i = 0;

  CSV.foreach(csvfile) do |rec|
      arraycpu[i] = rec[1]
      arraymem[i] = rec[4]
      arrayread[i] = rec[5]
      arraywrite[i] = rec[6]
      arraytcpconn[i] = rec[7]
      i = i+1;
  end

  arraycpu.shift
  arraycpu.collect! { |item|
    item.to_f
  }

  arraymem.shift
  arraymem.collect! { |item|
    item.to_f/10000.0
  }
  arrayread.shift
  arrayread.collect! { |item|
    item.to_f/100.0
  }
  arraywrite.shift
  arraywrite.collect! { |item|
    item.to_f/100.0
  }

  arraytcpconn.shift
  arraytcpconn.collect! { |item|
    item.to_f
  }
  g = Gruff::Line.new();
  g.title = "Server Monitoring Graph";
  g.data("CPU%", arraycpu)
  g.data("Memory(*10MB)", arraymem, "#0000FF")
  g.data("Reads(% Time)", arrayread, "#FF0000")
  g.data("Writes(% Time)", arraywrite, "#FFFFFF")
  g.data("TCP Conns", arraytcpconn, "	#FF00FF")
  g.write(targetfile)


end

# Sample usage :
filename = "D:\\Reporting_perf\\30users\\10_201_10_225-20110624-180056\.csv"
targetname = "D:\\Reporting_perf\\30users\\perf_mon_30_225\.png"
parserperfmon(filename,targetname);