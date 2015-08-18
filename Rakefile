require 'logger'

def logger
  @logger ||= Logger.new(STDERR).tap do |l|
    l.level = ENV['DEBUG'] ? Logger::DEBUG : Logger::WARN
  end
end

def check_file(file:, desc:)
  logger.debug "check_file #{file}"
  raise "#{desc} doesn't exist" unless File.exists? file
end

def check_contents(file:, str:)
  logger.debug "check_contents #{file} #{str}"
  contents = `cat #{file}`
  logger.debug "check_contents #{contents}"
  raise "Invalid contents for #{file}" unless contents.match(str)
end

def cmd cmd
  logger.debug(cmd)
  `#{cmd}`.tap do |out|
    logger.debug(out)
  end
end

def docker_machine_name
  ENV['DOCKER_MACHINE_NAME'] || 'dev'
end

def docker_machine_ip
  $docker_machine_ip ||= cmd("docker-machine ip #{docker_machine_name}").chomp
end

namespace :var do
  task :docker_machine do
    active = cmd("docker-machine active").chomp
    raise 'Docker machine not running' unless active.match(docker_machine_name)
  end

  task :docker_ip => ['var:docker_machine'] do
    docker_machine_ip
  end
end

namespace :cmd do
  task :route do
    routes = cmd('netstat -rn | grep 172.17')
    if !routes.match(docker_machine_ip)
      raise "Routes not configured correctly\n try 'sudo route -n add 172.17.0.0/16 `docker-machine ip #{docker_machine_name}`'"
    end
  end

  task :ping do
    cmd("ping -c 1 #{docker_machine_ip}")
  end
end

namespace :files do
  task :resolver do
    check_file file: '/etc/resolver/web', desc: 'Web Resolver'
    check_contents file: '/etc/resolver/web', str: docker_machine_ip
  end
end

task :check => [ 'var:docker_ip', 'files:resolver', 'cmd:route' ] do
  puts "Looks all good to me!"
end
