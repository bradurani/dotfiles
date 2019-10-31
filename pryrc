if defined?(PryByebug)
  Pry.commands.alias_command 'cc', 'continue'
  Pry.commands.alias_command 'ss', 'step'
  Pry.commands.alias_command 'nn', 'next'
  Pry.commands.alias_command 'ff', 'finish'
end
Pry.commands.alias_command 'ee', 'exit'
# Pry.commands.alias_command 'e!', 'exit!'
Pry.commands.alias_command 'dd', 'disable-pry' rescue nil
Pry.commands.alias_command "hh", "hist -T 20", desc: "Last 20 commands"
Pry.commands.alias_command "hg", "hist -T 20 -G", desc: "Up to 20 commands matching expression"
Pry.commands.alias_command "hG", "hist -G", desc: "Commands matching expression ever used"
Pry.commands.alias_command "hr", "hist -r", desc: "hist -r <command number> to run a command"

# Pry::Commands.command /^$/, "repeat last command" do
#   _pry_.run_command Pry.history.to_a.last
# end

# Pry.config.prompt = Pry::NAV_PROMPT

# gem install pry-theme
# pry-theme install xoria256 #from inside pry
# Pry.config.theme = "xoria256"

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
  warn "awesome_print not installed"
end

# begin
#   require 'factory_girl'
#   FactoryGirl.find_definitions
#   include FactoryGirl::Syntax::Methods
# rescue => e
# end

if ENV['RAILS_ENV'] || defined?(ActiveRecord)
  begin
    ActiveRecord::Base.logger = Logger.new STDOUT
  rescue LoadError => e
    puts 'could not set ActiveRecord::Base.logger'
  end
  begin
    puts 'loading eyeballs'
    require 'pg-eyeballs'
  rescue LoadError => e
    puts 'could not load pg-eyeballs'
  end
else
  puts 'skipping'
end


# def time(repetitions = 100, &block)
#   require 'benchmark'
#   Benchmark.bm{|b| b.report{repetitions.times(&block)}}
# end

Pry::Commands.command "sql", "Send sql over AR." do |query|
  if ENV['RAILS_ENV'] || defined?(Rails)
    ap ActiveRecord::Base.connection.select_all(query).to_a
  else
    ap "No rails env defined"
  end
end

Pry::Commands::command "caller_method" do |depth|
  depth = depth.to_i || 1
  if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
    file   = Regexp.last_match[1]
    line   = Regexp.last_match[2].to_i
    method = Regexp.last_match[3]
    output.puts [file, line, method]
  end
end

Pry::Commands.block_command('enable-pry', 'Enable `binding.pry` feature') do
  ENV['DISABLE_PRY'] = nil
end

def rr
  reload!
end

  class Object

    def local_methods(obj = self)
      (obj.methods - obj.class.superclass.instance_methods).sort
    end

    def ri(method = nil)
      unless method && method =~ /^[A-Z]/ # if class isn't specified
        klass = self.kind_of?(Class) ? name : self.class.name
        method = [klass, method].compact.join('#')
      end
      puts `ri '#{method}'`
    end
  end

