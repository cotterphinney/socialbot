require 'tempfile'

class RespondJob
  @queue = :bot
  
  def self.perform
    all_messages = Message.select("distinct body").where(artificial: false)
    source_messages = all_messages.map { |m| m.body }
    
    python_script_path = File.join File.dirname(__FILE__), 'hngen.py'
    
    temp_file = Tempfile.new("socialbot")
    temp_file.write source_messages.join("\n")
    temp_file.close
    
    IO.popen(["python",python_script_path],temp_file.path) do |io|
      puts io.read
    end
    
    temp_file.unlink
  end
end