require 'spec_helper'

describe Webxtractor, "basic functionality" do

  context ".get" do
    let(:result) { Webxtractor.get(url) }
    let(:uri_double) { double :uri }

    context "valid url" do
      let(:url) { 'http://www.example.com' }

      it "calls .parse with website body" do
        expect(URI).to receive(:parse).and_return(uri_double)
        expect(uri_double).to receive(:read).and_return("<html><title>hello world</title></html>")
        expect(Webxtractor).to receive(:parse).and_call_original

        expect(result.title).to eq("hello world")
      end
    end

    context "url is nil" do
      let(:url) { nil }

      it "calls .parse with website body" do
        expect(result).to eq(nil)
      end
    end
  end

  context ".parse" do
    let(:result) { Webxtractor.parse(body) }

    context 'regular title tag' do
      let(:body) { "<html><title>hello world</title></html>" }

      it "extracts correct title" do
        expect(result.title).to eq("hello world")
      end
    end

    context 'regular title tag' do
      let(:body) { "<html><title >hello world</title></html>" }

      it "extracts correct title" do
        expect(result.title).to eq("hello world")
      end
    end

    context 'regular title tag' do
      let(:body) { "<html><title>hello\r\nworld</title></html>" }

      it "extracts correct title" do
        expect(result.title).to eq("hello world")
      end
    end

    context 'title tag outside html' do
      let(:body) { "<html></html><title>hello bar</title>" }

      it "should find result" do
        expect(result.title).to eq("hello bar")
      end
    end

    context 'two title tags' do
      let(:body) { "<html><title>hello foo</title>"\
                   "<title>hello bar</title></html>" }

      it "returns array with the two tag contents" do
        expect(result.title).to eq(["hello foo", "hello bar"])
      end
    end

    context 'meta description' do
      let(:body) { "<meta name='description' content='HelloWorld'>" }

      it "returns array with the two tag contents" do
        expect(result.meta_description).to eq("HelloWorld")
      end
    end

    context 'meta description' do
      let(:body) { "<meta name='keywords' content='keyzauberwort'/>" }

      it "returns array with the two tag contents" do
        expect(result.meta_keywords).to eq("keyzauberwort")
      end
    end
  end

  context ".normalize" do
    it 'normalizes string' do
      expect(Webxtractor.send :normalize, ' foo ').to eq('foo')
    end

    it 'does not throw error' do
      expect(Webxtractor.send :normalize, nil).to eq(nil)
    end

    it 'normalizes string with one line break' do
      expect(Webxtractor.send :normalize, "foo\r\nbar").to eq("foo bar")
    end

    it 'normalizes string with many line breaks' do
      expect(Webxtractor.send :normalize, "foo\r\n\n\nbar").to eq("foo bar")
    end
  end
end
