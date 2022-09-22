# frozen_string_literal: true

require "spec_helper"

RSpec.describe Coverart::Client do
  subject(:client) { described_class.new }

  let(:uuid) { SecureRandom.uuid }

  describe "#get" do
    context "with successful response" do
      before do
        stub_client_request("/release/#{uuid}").to_return(status: 200, body: fixture("release.json"))
      end

      it { expect(client.get("/release/#{uuid}")).to be_a(Hash) }
      it { expect(client.get("/release/#{uuid}")).to include("images") }
    end

    context "with multiple redirections" do
      before do
        stub_client_request("/release/#{uuid}")
          .to_return(status: 307, headers: {"Location" => "http://coverartarchive.org/mbid-#{uuid}/index.json"})

        stub_client_request("/mbid-#{uuid}/index.json")
          .to_return(status: 302, headers: {"Location" => "http://coverartarchive.org/items/mbid-#{uuid}/index.json"})

        stub_client_request("/items/mbid-#{uuid}/index.json")
          .to_return(status: 200, body: fixture("release.json"))
      end

      it { expect(client.get("/release/#{uuid}")).to be_a(Hash) }
      it { expect(client.get("/release/#{uuid}")).to include("images") }
    end

    context "when MBID not found" do
      before do
        stub_client_request("/release/#{uuid}").to_return(status: 404, body: fixture("404.html"))
      end

      it { expect(client.get("/release/#{uuid}")).to be_nil }
    end

    context "with invalid UUID" do
      before do
        stub_client_request("/release/#{uuid}").to_return(status: 400, body: fixture("400.html"))
      end

      it { expect { client.get("/release/#{uuid}") }.to raise_error("Unexpected response (400) at /release/#{uuid}") }
    end
  end

  describe "#front" do
    context "with standard redirections" do
      before do
        stub_client_request("/release/#{uuid}/front").to_return(status: 307, headers: {"Location" => "http://archive.org/download/mbid.jpg"})
      end

      it { expect(client.front(uuid)).to be_a(String) }
      it { expect(client.front(uuid)).to match(%r{\.jpg\Z}) }
    end

    context "when MBID not found" do
      before do
        stub_client_request("/release/#{uuid}/front").to_return(status: 404, body: fixture("404.html"))
      end

      it { expect(client.front(uuid)).to be_nil }
    end

    context "with invalid UUID" do
      before do
        stub_client_request("/release/#{uuid}/front").to_return(status: 400, body: fixture("400.html"))
      end

      it { expect { client.front(uuid) }.to raise_error("Unexpected response (400) at /release/#{uuid}/front") }
    end
  end

  describe "#back" do
    context "with standard redirections" do
      before do
        stub_client_request("/release/#{uuid}/back").to_return(status: 307, headers: {"Location" => "http://archive.org/download/mbid.jpg"})
      end

      it { expect(client.back(uuid)).to be_a(String) }
      it { expect(client.back(uuid)).to match(%r{\.jpg\Z}) }
    end

    context "when MBID not found" do
      before do
        stub_client_request("/release/#{uuid}/back").to_return(status: 404, body: fixture("404.html"))
      end

      it { expect(client.back(uuid)).to be_nil }
    end

    context "with invalid UUID" do
      before do
        stub_client_request("/release/#{uuid}/back").to_return(status: 400, body: fixture("400.html"))
      end

      it { expect { client.back(uuid) }.to raise_error("Unexpected response (400) at /release/#{uuid}/back") }
    end
  end

  describe "#group" do
    context "with standard redirections" do
      before do
        stub_client_request("/release-group/#{uuid}/front").to_return(status: 307, headers: {"Location" => "http://archive.org/download/mbid.jpg"})
      end

      it { expect(client.group(uuid)).to be_a(String) }
      it { expect(client.group(uuid)).to match(%r{\.jpg\Z}) }
    end

    context "when MBID not found" do
      before do
        stub_client_request("/release-group/#{uuid}/front").to_return(status: 404, body: fixture("404.html"))
      end

      it { expect(client.group(uuid)).to be_nil }
    end

    context "with invalid UUID" do
      before do
        stub_client_request("/release-group/#{uuid}/front").to_return(status: 400, body: fixture("400.html"))
      end

      it { expect { client.group(uuid) }.to raise_error("Unexpected response (400) at /release-group/#{uuid}/front") }
    end
  end
end
