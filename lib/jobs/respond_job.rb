require 'tempfile'

class RespondJob
  @queue = :bot
  
  def self.perform
    all_messages = Message.select("distinct body").where(artificial: false)
    source_messages = all_messages.map { |m| m.body }
    source_messages.shuffle!
    
    python_script_path = File.join File.dirname(__FILE__), 'hngen.py'
    
    temp_file = Tempfile.new("socialbot")
    temp_file.write source_messages.join("\n")
    temp_file.close
    
    results = nil
    
    IO.popen(["python",python_script_path,temp_file.path]) do |io|
      results = io.read
    end
    
    temp_file.unlink
    
    responses = results.split("\n")
    
    messages = Message.where(artificial: false,responded: false).order("created_at asc").to_a
    
    responses.shuffle!
    
    responses.each do |response|
      msg = messages.shift
      break if msg.nil? 
      resp = Message.new
      resp.to_number = msg.from_number
      resp.from_number = '+14086596627'
      resp.body = response
      resp.artificial = true
      resp.parent = msg
      resp.save!
      resp.send!
      
      msg.responded = true
      msg.save!
    end
    
    remaining = Message.where(responded: false,artificial: false).count
    puts "Messages to still respond to: #{remaining}"
  end
end