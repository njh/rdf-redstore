$:.unshift File.dirname(__FILE__) + "/../lib/"

require 'rubygems'
require 'rdf'
require 'spec'

def start_redstore(cmd='redstore')
  # Check that redstore is available
  unless Kernel::system("which #{cmd} > /dev/null")
    raise "redstore command is not available on this system"
  end

  begin
    port = 10000 + ((rand(10000) + Time.now.to_i) % 10000);
    count = 0
    
    puts "** Starting RedStore on port #{port}\n";
    pid = fork { exec("#{cmd} -q -n -p #{port} -b localhost -s memory") }
    raise "Failed to start RedStore" if pid <= 0
    
    # Check if the process started ok
    begin
      Process.kill(0,pid)
    rescue Errno::ESRCH
      pid = nil
    end

    sleep(1)
  end while (pid.nil? and count < 10)

  [port,pid]
end

def stop_redstore(pid)
  count = 0

  return if pid.nil?

  while (Process::waitpid(pid, Process::WNOHANG).nil? and count < 10) do
    if (count<5)
      Process.kill(2, pid)
    else
      puts "** Sending KILL to #{pid}"
      Process.kill(9, pid)
    end
    
    sleep(1)
    count += 1
  end
end
