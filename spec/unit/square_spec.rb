# frozen_string_literal: true

require_relative './../../lib/square'

RSpec.describe Square do
  subject(:square) { described_class.new }

  # Need to finish this test
  xdescribe '#valid_destination?' do
    subject(:square) { described_class.new(content) }
    let(:content) { instance_spy(Piece) }

    it 'sends valid_destination? to content' do
      square.valid_destination?()

      expect(content).to have_received(:valid_destination?)
    end
  end

  describe '#empty?' do
    context 'when Square content is nil' do
      subject(:square) { described_class.new(nil) }

      it 'returns true' do
        expect(square.empty?).to be(true)
      end
    end

    context 'when Square content is an object' do
      let(:object) { double }

      before do
        square.fill(object)
      end

      it 'returns false' do
        expect(square.empty?).to be(false)
      end
    end
  end

  describe '#empty' do
    context 'when content has some value' do
      subject(:square) { described_class.new(some_content) }
      let(:some_content) { double }

      it 'sets square content to nil' do
        square.empty

        expect(square.content).to be(nil)
      end

      it 'returns the previous value of content' do
        expect(square.empty).to eq(some_content)
      end
    end
  end

  describe '#fill' do
    context 'when square content is nil' do
      subject(:square) { described_class.new(nil) }
      let(:item) { double }

      it 'sets square content to item' do
        expect { square.fill(item) }
          .to change { square.content }
          .to(item)
      end
    end

    context 'when square content contains something' do
      subject(:square) { described_class.new(previous_item) }
      let(:previous_item) { double }
      let(:new_item) { double }

      it 'sets square content from previous item to new item' do
        expect { square.fill(new_item) }
          .to change { square.content }
          .from(previous_item)
          .to(new_item)
      end
    end
  end
end
