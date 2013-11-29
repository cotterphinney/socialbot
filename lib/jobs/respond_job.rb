class RespondJob
  @queue = :bot
  
  def self.perform
    all_messages = Message.select("distinct body").where(artificial: false)
    source_messages = all_messages.map { |m| m.body }
    
    python_script_path = File.join File.dirname(__FILE__), 'hngen.py'
    
    File.open("/tmp/blah",'w') { |f| f.write source_messages.join("\n") }
    
    IO.popen(["python",python_script_path],"/tmp/blah") do |io|
      puts io.read
    end
  end
end