module CoverArt
  class Client
    attr_reader :http

    def initialize &block
      @http ||= Faraday.new url: 'http://coverartarchive.org' do |f|
        yield f if block_given?
        f.adapter Faraday.default_adapter
      end
    end

    def get url
      response = http.get url

      case response.status
      when 404  then nil
      when 200  then JSON.parse response.body
      when 300..310
        if response.headers[:location].match /\.(jpg|jpeg|png|gif)/
          response.headers[:location]
        else
          get response.headers[:location]
        end
      else
        raise "Unexpected response (#{ response.status }) at #{ url }"
      end
    end

    def front mbid
      get "/release/#{ mbid }/front"
    end

    def back mbid
      get "/release/#{ mbid }/back"
    end

    def group mbid
      get "/release-group/#{ mbid }/front"
    end
  end
end
