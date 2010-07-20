require "foreman/export"
require "foreman/utils"

class Foreman::Export::Base

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def export
    raise "export method must be overridden"
  end

private ######################################################################

  def error(message)
    raise Foreman::Export::Exception.new(message)
  end

  def say(message)
    puts "[foreman export] %s" % message
  end

  def export_template(name)
    File.read(File.expand_path("../../../../export/#{name}", __FILE__))
  end

  def port_for(base_port, app, num)
    base_port ||= 5000
    offset = engine.processes.keys.sort.index(app) * 100
    base_port.to_i + offset + num - 1
  end

  def write_file(filename, contents)
    say "writing: #{filename}"

    File.open(filename, "w") do |file|
      file.puts contents
    end
  end

end