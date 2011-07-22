class Puppet::Util::NetworkDevice
  class << self
    attr_reader :current
  end

  def self.init(device)
    require "puppet/util/network_device/#{device.provider}/device"
    @current = Puppet::Util::NetworkDevice.const_get(device.provider.capitalize).const_get(:Device).new(device.url)
  rescue => detail
    raise "Can't load #{device.provider} for #{device.name}: #{detail}"
  end

  # for tests reset
  def self.clear
    @current = nil
  end
end