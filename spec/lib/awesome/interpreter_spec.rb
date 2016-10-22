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
