# frozen_string_literal: true

describe BakeryApp::ExceptionView do
  subject(:view) { described_class.new(exception) }

  let(:exception) { BakeryApp::Error.new('error') }

  describe '#content' do
    it { expect(subject.content).to eql('BakeryApp::Error error') }
  end
end
