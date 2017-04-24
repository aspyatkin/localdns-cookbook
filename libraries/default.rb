require 'resolv'

module ChefCookbook
  module LocalDNS
    def self.resolve_service(service, protocol, domain)
      target = nil
      port = nil

      Resolv::DNS.open do |dns|
        r = dns.getresource(
          "_#{service}._#{protocol}.#{domain}",
          Resolv::DNS::Resource::IN::SRV
        )
        target = r.target.to_s
        port = r.port
      end

      return target, port
    end

    def self.resolve_host(domain)
      address = nil

      Resolv::DNS.open do |dns|
        r = dns.getaddress(domain)
        address = r.to_s
      end
    end
  end
end
