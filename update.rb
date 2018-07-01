#!/usr/bin/env ruby

require "erb"
require "ostruct"
require "yaml"

# run external command and test success
def run(cmd)
  puts "#{cmd}"
  success = system(cmd)
  exit $?.exitstatus unless success
end

def status(msg)
  puts "\n==> #{msg}"
end

# update docker files for version
def update_version(chain, version, opts={})
  dir = File.join(chain, version)
  status "Update version #{dir}"

  # initialize directory
  run "rm -rf #{dir}"
  run "mkdir -p #{dir}"
  run "cp docker-entrypoint.sh #{dir}"

  # render Dockerfile
  opts[:version] = version

  dockerfile = ERB.new(File.read("Dockerfile.erb"), nil, "-")
  result = dockerfile.result(OpenStruct.new(opts).instance_eval { binding })
  File.write(File.join(dir, "Dockerfile"), result)
end

def load_versions
  versions = YAML.load_file('versions.yml')
  versions.select! { |k, v| k === ENV['chain'] } if ENV['chain']
  versions
end

if __FILE__ == $0
  load_versions.each do |chain, versions|
    versions.each do |version, opts|
      update_version(chain, version, opts)
    end
  end
end
