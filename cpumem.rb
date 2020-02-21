supported_os = %w[Linux AIX FreeBSD Darwin windows SunOS]
kernel       = Facter.value(:kernel)


if supported_os.include? kernel
  
   def self.uw_memused
    if File.exists?("/proc/meminfo")
      File.open("/proc/meminfo", "r") do |file|
        @result = file.read
      end
    end

    @memstat = @result.split("\n").collect{|x| x.strip}
    @memtotal = @memstat[0].gsub(/[^0-9]/, "")
    @memactive = @memstat[5].gsub(/[^0-9]/, "")
    @memactivecalc = (@memactive.to_f * 100) / @memtotal.to_f
    @memusagepercentage = @memactivecalc.round
  end
  
  
  
  Facter.add("memoryfree_#{fs}") do
      confine kernel: supported_os
      setcode do
        used
      end # end setcode
  end # end facter.add
  
  
  
  
  
end # if suppored_os kernel  
