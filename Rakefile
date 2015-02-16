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

namespace :var do
  task :boot2docker do
    status = cmd('boot2docker status')
    raise 'Boot2docker not running' unless status.match(/running/)
  end
  task :boot2docker_ip => ['var:boot2docker'] do
    $boot2docker_ip = cmd('boot2docker ip').chomp
  end
end

namespace :cmd do
  task :route do
    routes = cmd('netstat -rn | grep 172.17')
    if !routes.match($boot2docker_ip)
      raise "Routes not configured correctly"
    end
  end

  task :ping do
    cmd("ping -c 1 #{$boot2docker_ip}")
  end
end

namespace :files do
  task :resolver do
    check_file file: '/etc/resolver/web', desc: 'Web Resolver'
    check_contents file: '/etc/resolver/web', str: $boot2docker_ip
  end
end

task :check => [ 'var:boot2docker_ip', 'files:resolver', 'cmd:route'] do
end
