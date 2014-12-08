require 'spec_helper'

module Codebreaker
  describe Game do
    let(:game) { Game.new }

    before do
      game.start
    end

    context "#start" do
      it "saves secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end
      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context "#user_code" do
      it "Guess 1 of 4" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1555")

        expect(res).to  eql("+")
      end
      it "Guess 2 of 4" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1255")

        expect(res).to  eql("++")
      end
      it "Guess 3 of 4" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1235")

        expect(res).to  eql("+++")
      end
      it "Guess 1 of 4 with all number in secret code" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1111")

        expect(res).to  eql("+---")
      end
      it "Guess 2 of 4 with all number in secret code" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1211")

        expect(res).to  eql("++--")
      end
      it "Guess 2 of 4 with all number in secret code" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1211")

        expect(res).to  eql("++--")
      end
      it "Guess 3 of 4 with all number in secret code" do
        game.instance_variable_set(:@secret_code, "1234")
        res  = game.user_code("1231")

        expect(res).to  eql("+++-")
      end
      it "win game" do
        game.instance_variable_set(:@secret_code, "1234")
        res = game.user_code("1234")

        expect(res).to eql("++++")
      end
    end

    context "#valid?" do
      it "code be valid?" do
        code = game.valid?("1234")
        expect(code).to eql(0)
      end
      it "code in not valid" do
        code = game.valid?("nOtF0RMAT")
        expect(code).to eql(nil)
      end
    end
  end
end