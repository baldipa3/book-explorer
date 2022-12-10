require 'json'
require 'net/http'

module ExternalServices
  class RequestBin
    def self.send_notification(url)
      uri = URI('https://eo6yxili72uh3ue.m.pipedream.net')
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      
      req.body = {
        "url": url
      }.to_json
      
      Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end
    end
  end
end


