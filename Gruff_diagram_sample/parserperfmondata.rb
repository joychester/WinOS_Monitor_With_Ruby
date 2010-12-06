# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'csv'
require 'gruff'

def parserperfmon(csvfile, targetfile)
  arraycpu = Array.new;
  arraymem = Array.new;
  arrayread = Array.new;
  arraywrite = Array.new;
  
  i = 0;

  CSV.foreach(csvfile) do |rec|
      arraycpu[i] = rec[1]
      arraymem[i] = rec[4]
      arrayread[i] = rec[5]
      arraywrite[i] = rec[6]
      i = i+1;
  end

  arraycpu.shift
  arraycpu.collect! { |item|
    item.to_f
  }

  arraymem.shift
  arraymem.collect! { |item|
    item.to_f/100000.0
  }
  arrayread.shift
  arrayread.collect! { |item|
    item.to_f/100.0
  }
  arraywrite.shift
  arraywrite.collect! { |item|
    item.to_f/100.0
  }
  
  g = Gruff::Line.new();
  g.title = "Server Monitoring Graph";
  g.data("CPU%", arraycpu)
  g.data("Memory", arraymem, "#0000FF")
  g.data("Reads", arrayread, "#FF0000")
  g.data("Writes", arraywrite, "#FFFFFF")
  g.write(targetfile)


end

filename = "D:\\performance_diagram\\perf_mon\.csv"
targetname = "D:\\performance_diagram\\perf_mon.png"
parserperfmon(filename,targetname);