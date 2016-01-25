require 'spec_helper'

describe Webxtractor, "basic functionality" do

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

      it "should not find result" do
        pending
        expect(result.title).to be_nil
      end
    end

    context 'two title tags' do
      let(:body) { "<html><title>hello foo</title>"\
                   "<title>hello bar</title></html>" }

      it "gets first title" do
        pending
        expect(result.title).to eq("hello foo")
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
