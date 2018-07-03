#!/usr/bin/env ruby

require "./update"

def build_image(chain, version, opts)
  dir = File.join(chain, version)
  tag = "#{chain}:#{version}"

  # some clients self-report a different formatted version
  # so we allow this to be overridden in versions.yml
  client_version = opts["client_version"] || "#{version}"

  run "docker build -t #{tag} #{dir}"
  run "docker run --rm #{tag} sh -c 'test -n \"$(#{chain}d --version | grep \"#{client_version}\")\"'"
end

if __FILE__ == $0
  load_versions.each do |chain, versions|
    versions.each do |version, opts|
      build_image(chain, version, opts)
    end
  end
end
