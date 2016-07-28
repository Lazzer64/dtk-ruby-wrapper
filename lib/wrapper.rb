#!/usr/bin/ruby
require 'json'

def run(entry_point, properties, outputs, requirements)
  requirements.each do |requirement|
    require_relative(requirement)
  end

  klass = Object.const_get(entry_point.split('.')[0])
  funct = entry_point.split('.')[1]

  resp = klass.send(funct, properties)

  ret = {}
  outputs.each do |output|
    if resp.key?(output)
      ret[output] = resp[output]
    else
      ret[output.to_sym] = resp[output.to_sym]
    end
  end
  puts ret
  exit(0)
rescue => e
  STDERR.puts e.to_s
  exit(1)
end

p = JSON.parse(ARGV[0])
run(p['entry_point'], p['properties'], p['outputs'], p['requirements'])
