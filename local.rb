require 'coverart'

def api
  @api ||= CoverArt::Client.new
end
