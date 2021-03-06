provides "remote_services"

output = `netstat -tlpen`
if output
  lines = output.split(/\n/).reject(&:empty?)[2..-1]
end

remote_services Mash.new
if lines
  for line in lines
    line_data = line.split()
    remote_services[line_data[3]] = {
      :protocol => line_data[0],
      :ip => line_data[3].split(":")[0],
      :port => line_data[3].split(":")[-1],
      :pid => line_data[-1].split("/")[0],
      :process => line_data[-1].split("/")[1]
    }
  end
end
