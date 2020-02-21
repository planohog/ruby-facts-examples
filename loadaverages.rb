Facter.add('loadaverage')
  setcode do
    Facter::Core::Execution.execute("cat /proc/loadavg | awk '{print $1,$2,$3}' ")
  end
end
    
