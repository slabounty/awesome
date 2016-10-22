require 'spec_helper'

describe Lexer do
  context "number" do
    it "handles numbers" do
      expect(Lexer.new.tokenize("1")).to eq([[:NUMBER, 1]])
    end
  end

  context "strings" do
    it "handles strings" do
      expect(Lexer.new.tokenize('"hi"')).to eq([[:STRING, "hi"]])
    end
  end

  context "identifiers" do
    it "handles identifiers" do
      expect(Lexer.new.tokenize('name')).to eq([[:IDENTIFIER, "name"]])
    end
  end

  context "constants" do
    it "handles constants" do
      expect(Lexer.new.tokenize('Name')).to eq([[:CONSTANT, "Name"]])
    end
  end

  context "operators" do
    it "handles single character operators" do
      expect(Lexer.new.tokenize('+')).to eq([["+", "+"]])
    end

    it "handles double character operators" do
      expect(Lexer.new.tokenize('||')).to eq([["||", "||"]])
    end
  end

  context "indent" do
    let(:code) {
      <<-CODE
if 1:
  if 2:
    print("...")
    if false:
      pass
    print ("done!")
  2

print "The End"
      CODE
    }

    let(:tokens) {
      [
        [:IF, "if"], [:NUMBER, 1],
        [:INDENT, 2],
        [:IF, "if"], [:NUMBER, 2],
        [:INDENT, 4],
        [:IDENTIFIER, "print"], ["(", "("], [:STRING, "..."], [")", ")"], [:NEWLINE, "\n"],
        [:IF, "if"], [:FALSE, "false"],
        [:INDENT, 6],
        [:IDENTIFIER, "pass"],
        [:DEDENT, 4], [:NEWLINE, "\n"],
        [:IDENTIFIER, "print"],["(", "("],
        [:STRING, "done!"], [")",")"],
        [:DEDENT, 2], [:NEWLINE, "\n"],
        [:NUMBER, 2],
        [:DEDENT, 0], [:NEWLINE, "\n"],
        [:NEWLINE, "\n"],
        [:IDENTIFIER, "print"], [:STRING, "The End"]
      ]
    }

    it "tokenizes the code" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end
  end
end
