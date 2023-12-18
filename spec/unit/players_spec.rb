# frozen_string_literal: true

require_relative "../../lib/players"

RSpec.describe Players do
  subject(:players) { described_class.new }

  describe "#swap" do
    context "when @current is :white" do
      subject(:players) { described_class.new(:white) }

      it "changes @current to :black" do
        expect { players.swap }.to change { players.current }
          .from(:white)
          .to(:black)
      end

      it "returns @current" do
        expect(players.swap).to eq(players.current)
      end
    end

    context "when @current is :black" do
      subject(:players) { described_class.new(:black) }

      it "changes @current to :white" do
        expect { players.swap }.to change { players.current }
          .from(:black)
          .to(:white)
      end

      it "returns @current" do
        expect(players.swap).to eq(players.current)
      end
    end
  end

  describe "#other" do
    context "when current is :black" do
      subject(:players) { described_class.new(:black) }

      it "returns :white" do
        expect(players.other).to be(:white)
      end
    end

    context "when current is :white" do
      subject(:players) { described_class.new(:white) }
      it "returns :black" do
        expect(players.other).to be(:black)
      end
    end
  end

  describe "#current" do
    context "when players is initialized without arguments" do
      it "returns :white" do
        expect(players.current).to eq(:white)
      end
    end

    context "when #swap is sent to players once after initialize" do
      before do
        players.swap
      end

      it "returns :black" do
        expect(players.current).to eq(:black)
      end
    end

    context "when #swap is sent to players twice after initialize" do
      before do
        2.times do
          players.swap
        end
      end

      it "returns :white" do
        expect(players.current).to eq(:white)
      end
    end
  end
end
