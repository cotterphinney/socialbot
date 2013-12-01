require 'tempfile'

class RespondJob
  @queue = :bot
  
  def self.perform
    all_messages = Message.select("distinct body").where(artificial: false)
    source_messages = all_messages.map { |m| m.body }
    
    python_script_path = File.join File.dirname(__FILE__), 'hngen.py'
    
    temp_file = Tempfile.new("socialbot")
    temp_file.write source_messages.join("\n")
    puts temp_file.path
    temp_file.close
    
    results = nil
    
    IO.popen(["python",python_script_path,temp_file.path]) do |io|
      results = io.read
    end
    
    temp_file.unlink
    
    responses = results.split("\n")
    
    messages = Message.where(artificial: false,responded: false,from_number: '+13107012937').order("created_at asc").to_a
    
    responses.each do |response|
      msg = Messages.shift
      resp = Message.new
      resp.to_number = msg.from_number
      resp.from_number = '+14086596627'
      resp.body = response
      resp.artifical = true
      resp.parent = msg
      resp.save!
      resp.send!
      
      msg.responded = true
      msg.save!
    end
  end
end