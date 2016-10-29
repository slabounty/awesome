require 'spec_helper'

describe Interpreter do
  describe "number" do
    it "works with numbers" do
      expect(Interpreter.new.eval("1").ruby_value).to eq(1)
    end
  end

  describe "true" do
    it "works with true" do
      expect(Interpreter.new.eval("true").ruby_value).to eq(true)
    end
  end

  describe "assignment" do
    it "assigns" do
      expect(Interpreter.new.eval("a = 2; 3; a").ruby_value).to eq(2)
    end
  end

  describe "math" do
    it "adds" do
      expect(Interpreter.new.eval("2 + 3").ruby_value).to eq(5)
    end

    it "subtracts" do
      expect(Interpreter.new.eval("5 + 3").ruby_value).to eq(8)
    end
  end

  describe "comparison" do
    it "compares <" do
      expect(Interpreter.new.eval("5 < 3").ruby_value).to eq(false)
    end

    it "compares >" do
      expect(Interpreter.new.eval("5 > 3").ruby_value).to eq(true)
    end
  end

  describe "logical &&" do
    context "when both sides are true" do
      it "is true" do
        expect(Interpreter.new.eval("(5 > 3) && (2 < 3)").ruby_value).to eq(true)
      end
    end

    context "when both sides are not true" do
      it "is false" do
        expect(Interpreter.new.eval("(5 < 3) && (3 > 2)").ruby_value).to eq(false)
      end
    end
  end

  describe "logical ||" do
    context "when one side is true" do
      it "is true" do
        expect(Interpreter.new.eval("(5 > 3) || (3 < 2)").ruby_value).to eq(true)
      end
    end

    context "when both sides are not true" do
      it "is false" do
        expect(Interpreter.new.eval("(5 < 3) || (2 > 3)").ruby_value).to eq(false)
      end
    end
  end

  describe "methods" do
    it "runs methods" do
    code = <<-CODE
def boo(a):
  a

boo("yah!")
CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq("yah!")
    end
  end

  describe "reopen class" do
    it "reopens the class" do
      code = <<-CODE
class Number:
  def ten:
    10

1.ten
CODE

      expect(Interpreter.new.eval(code).ruby_value).to eq(10)
    end
  end

  describe "define class" do
    it "defines a class" do
      code = <<-CODE
class Pony:
  def awesome:
    true

Pony.new.awesome
CODE
      expect(Interpreter.new.eval(code).ruby_value).to eq(true)
    end
  end

  describe "if" do
    it "if's" do
      code = <<-CODE
if true:
  "works!"
CODE

      expect(Interpreter.new.eval(code).ruby_value).to eq("works!")
    end
  end

  describe "full test" do
    let(:code) {
      <<-CODE
class Worker:
  def does_it_work:
    "yeah"

worker_object = Worker.new
if worker_object:
  print(worker_object.does_it_work)
      CODE
    }

    it "prints" do
      Interpreter.new.eval(code)
      #expect(Interpreter.new.eval(code)).to eq("something")
    end
  end
end
