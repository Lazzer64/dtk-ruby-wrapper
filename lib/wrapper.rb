#!/usr/bin/ruby

def run(entry_point, properties, outputs, requirements)
  requirements.each do |requirement|
    require_relative(requirement)
  end

  obj = Object.const_get(entry_point).new(properties)
  resp = obj.create

  ret = {}
  outputs.each do |output|
    ret[output] = resp[output]
  end
  puts ret
end

opts = { region: 'us-west-2', stream_name: 'astreamname', shard_count: 1 }
run('Resource::Kinesis::Stream', opts, [:stream_arn], ['../../resource/lib/resource', '../../kinesis/lib/kinesis'])
