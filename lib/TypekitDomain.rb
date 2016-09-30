require 'typekit'

class TypekitDomain
  @@api_key = ENV['TYPEKIT_API_AUTH']
  @@kit_id = ENV['TYPEKIT_KIT_ID']
  @@app_domain = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com"

  def add
    kit = get_kit
    domains = kit.domains

    unless (domains.include? @@app_domain)
      domains << @@app_domain

      kit.update(domains: domains)
      kit.publish
    end

    domains = get_domains
    abort "Failed to add domain to whitelist" unless domains.include? @@app_domain
  end

  def remove
    kit = get_kit
    domains = kit.domains

    if (domains.include? @@app_domain)
      domains.delete @@app_domain

      kit.update(domains: domains)
      kit.publish
    end

    domains = get_domains
    abort "Failed to remove domain from whitelist" if domains.include? @@app_domain
  end


  private
  def get_kit
    typekit = Typekit::Client.new token: @@api_key
    typekit::Kit.find @@kit_id
  end

  def get_domains
    kit = get_kit
    kit.domains
  end
end
