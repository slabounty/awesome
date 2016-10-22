require 'spec_helper'

describe Parser do
  describe "#parse" do
    it "parses numbers" do
      expect(Parser.new.parse("1")).to eq(Nodes.new([NumberNode.new(1)]))
    end

    it "parses expressions" do
      expect(Parser.new.parse(%{1\n"hi"})).to eq(Nodes.new([NumberNode.new(1), StringNode.new("hi")]))
    end

    it "parses calls" do
      expect(Parser.new.parse("1.method")).to eq(Nodes.new([CallNode.new(NumberNode.new(1), "method", [])]))
    end

    context "assignment" do
      it "assigns local nodes" do
        expect(Parser.new.parse("a = 1")).to eq(Nodes.new([SetLocalNode.new("a", NumberNode.new(1))]))
      end

      it "assigns constant nodes" do
        expect(Parser.new.parse("A = 1")).to eq(Nodes.new([SetConstantNode.new("A", NumberNode.new(1))]))
      end
    end

    it "parses methods without parameters" do
      code = <<-CODE
def method:
  true
CODE
      nodes = Nodes.new([
        DefNode.new("method", [],
                    Nodes.new([TrueNode.new])
                   )
      ])

      expect(Parser.new.parse(code)).to eq(nodes)
    end

    it "parses a method with parameters" do
      code = <<-CODE
def method(a, b):
  true
      CODE

      nodes = Nodes.new(
        [
          DefNode.new("method", ["a", "b"],
                      Nodes.new([TrueNode.new])
                     )
        ])

      expect(Parser.new.parse(code)).to eq(nodes)
    end

    it "parses a class" do
      code = <<-CODE
class Muffin:
  true
CODE
      nodes = Nodes.new([
        ClassNode.new("Muffin",
                      Nodes.new([TrueNode.new])
                     )
      ])
      expect(Parser.new.parse(code)).to eq(nodes)
    end
  end

  context "arithmatic" do
    let(:nodes) { Nodes.new([
      CallNode.new(NumberNode.new(1), "+", [
        CallNode.new(NumberNode.new(2), "*", [NumberNode.new(3)])
      ])
    ])
    }

    context "without parenthesis" do
      it "parses correctly" do
        expect(Parser.new.parse("1 + 2 * 3")).to eq(nodes)
      end
    end

    context "with parenthesis" do
      it "parses correctly" do
        expect(Parser.new.parse("1 + (2 * 3)")).to eq(nodes)
      end
    end
  end

  context "binary operator" do
    let(:nodes) {
      Nodes.new([
        CallNode.new(
        CallNode.new(NumberNode.new(1), "+", [NumberNode.new(2)]),
          "||",
          [NumberNode.new(3)]
               )
      ])}
    it "parses a binary operator" do
      expect(Parser.new.parse("1 + 2 || 3")).to eq(nodes)
    end
  end

  context "if" do
    let(:code) {
      <<-CODE
if true:
  nil
CODE
    }

    let(:nodes) {
      Nodes.new([
        IfNode.new(TrueNode.new,
                   Nodes.new([NilNode.new])
                  )
      ])
    }

    it "parses an if" do
      expect(Parser.new.parse(code)).to eq(nodes)
    end
  end
end
