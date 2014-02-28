require 'spec_helper'

describe CoverArt::Client do

  let(:api) { CoverArt::Client.new }

  describe '#get' do

    context 'with successful response' do
      before { stub_get '/release/mdib', status: 200, body: fixture('release.json') }

      it { expect( api.get '/release/mdib' ).to be_a Hash }
      it { expect( api.get '/release/mdib' ).to include 'images' }
    end

    context 'with multiple redirections' do
      before { stub_get '/release/mdib'              , status: 307, headers: { 'Location' => CoverArt::Client::ENDPOINT + '/mbid-mdib/index.json' }}
      before { stub_get '/mbid-mdib/index.json'      , status: 302, headers: { 'Location' => CoverArt::Client::ENDPOINT + '/items/mbid-mdib/index.json' }}
      before { stub_get '/items/mbid-mdib/index.json', status: 200, body: fixture('release.json') }

      it { expect( api.get '/release/mdib' ).to be_a Hash }
      it { expect( api.get '/release/mdib' ).to include 'images' }
    end

    context 'when MBID not found' do
      before { stub_get '/release/mdib', status: 404, body: fixture('404.html') }

      it { expect( api.get '/release/mdib' ).to be_nil }
    end

    context 'with invalid UUID' do
      before { stub_get '/release/mdib', status: 400, body: fixture('400.html') }

      it { expect{ api.get '/release/mdib' }.to raise_error }
    end
  end

  describe '#front' do
    context 'with standard redirections' do
      before { stub_get '/release/mdib/front', status: 307, headers: { 'Location' => 'http://archive.org/download/mbid.jpg' }}

      it { expect( api.front 'mdib' ).to be_a String }
      it { expect( api.front 'mdib' ).to match %r{\.jpg\Z} }
    end

    context 'when MBID not found' do
      before { stub_get '/release/mdib/front', status: 404, body: fixture('404.html') }

      it { expect( api.front 'mdib' ).to be_nil }
    end

    context 'with invalid UUID' do
      before { stub_get '/release/mdib/front', status: 400, body: fixture('400.html') }

      it { expect{ api.front 'mdib/front' }.to raise_error }
    end
  end

  describe '#back' do
    context 'with standard redirections' do
      before { stub_get '/release/mdib/back', status: 307, headers: { 'Location' => 'http://archive.org/download/mbid.jpg' }}

      it { expect( api.back 'mdib' ).to be_a String }
      it { expect( api.back 'mdib' ).to match %r{\.jpg\Z} }
    end

    context 'when MBID not found' do
      before { stub_get '/release/mdib/back', status: 404, body: fixture('404.html') }

      it { expect( api.back 'mdib' ).to be_nil }
    end

    context 'with invalid UUID' do
      before { stub_get '/release/mdib/back', status: 400, body: fixture('400.html') }

      it { expect{ api.back 'mdib/back' }.to raise_error }
    end
  end

  describe '#group' do
    context 'with standard redirections' do
      before { stub_get '/release-group/mdib/front', status: 307, headers: { 'Location' => 'http://archive.org/download/mbid.jpg' }}

      it { expect( api.group 'mdib' ).to be_a String }
      it { expect( api.group 'mdib' ).to match %r{\.jpg\Z} }
    end

    context 'when MBID not found' do
      before { stub_get '/release-group/mdib/front', status: 404, body: fixture('404.html') }

      it { expect( api.group 'mdib' ).to be_nil }
    end

    context 'with invalid UUID' do
      before { stub_get '/release-group/mdib/front', status: 400, body: fixture('400.html') }

      it { expect{ api.group 'mdib/back' }.to raise_error }
    end
  end
end