require 'spec_helper'

describe Lexer do
  let(:lexer_code) { "spec/support/lexer" }

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

  context "if" do
    let(:code) { File.read("#{lexer_code}/if.awm") }

    let(:tokens) {
      [
        [:IF, "if"], [:NUMBER, 1],
        [:INDENT, 2],
          [:STRING, "this"], 
        [:DEDENT, 0]

      ]
    }
    it "parses an if" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end

  end

  context "if/else" do
    let(:code) { File.read("#{lexer_code}/if_else.awm") }

    let(:tokens) {
      [
        [:IF, "if"], [:NUMBER, 1],
        [:INDENT, 2],
          [:STRING, "this"], 
        [:DEDENT, 0], [:NEWLINE, "\n"],
        [:ELSE, "else"],
        [:INDENT, 2], [:STRING, "that"],
        [:DEDENT, 0]
      ]
    }
    it "parses an if/else" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end
  end

  context "comments" do
    let(:code) { File.read("#{lexer_code}/comment.awm") }

    let(:tokens) {
      [
        [:NEWLINE, "\n"],
        [:IF, "if"], [:NUMBER, 1],
        [:INDENT, 2],
          [:STRING, "this"], 
        [:DEDENT, 0], [:NEWLINE, "\n"],
        [:ELSE, "else"],
        [:INDENT, 2], [:STRING, "that"],
        [:DEDENT, 0]
      ]
    }
    it "parses an comments out" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end
  end

  context "methods" do
    let(:code) { File.read("#{lexer_code}/method.awm") }

    let("tokens") {
      [[:DEF, "def"], [:IDENTIFIER, "m"], 
       [:INDENT, 2], [:STRING, "hello"], [:NEWLINE, "\n"], 
       [:NUMBER, 5], ["+", "+"], [:NUMBER, 7], [:DEDENT, 0]]
    }

    it  "handles methods" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end
  end

  context "methods with comments" do
    let(:code) { File.read("#{lexer_code}/method_with_comments.awm") }

    let("tokens") {
      [
        [:NEWLINE, "\n"],
        [:DEF, "def"], [:IDENTIFIER, "m"], 
        [:INDENT, 2], [:STRING, "hello"], [:NEWLINE, "\n"],
        [:NUMBER, 5], ["+", "+"], [:NUMBER, 7], [:DEDENT, 0]]
    }

    it  "handles methods with comments" do
      result = Lexer.new.tokenize(code)
      expect(result).to eq(tokens)
    end
  end

  context "indent" do
    let(:code) { File.read("#{lexer_code}/indent.awm") }

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
