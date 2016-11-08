require 'spec_helper'

describe Interpreter do
  let(:interpreter_code) { "spec/support/interpreter" }

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
      code =  File.read("#{interpreter_code}/methods.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq("yah!")
    end
  end

  describe "methods with comments" do
    it "runs methods" do
      code =  File.read("#{interpreter_code}/methods_with_comments.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq("yah!")
    end
  end

  describe "reopen class" do
    it "reopens the class" do
      code =  File.read("#{interpreter_code}/reopen_class.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq(10)
    end
  end

  describe "define class" do
    it "defines a class" do
      code =  File.read("#{interpreter_code}/define_class.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq(true)
    end
  end

  describe "if" do
    it "if's" do
      code =  File.read("#{interpreter_code}/if.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq("works!")
    end
  end

  describe "if else" do
    it "if's else's" do
      code =  File.read("#{interpreter_code}/if_else.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq("works with else")
    end
  end

  describe "while" do
    it "implements while loops" do
      code =  File.read("#{interpreter_code}/while.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq(10)
    end
  end

  describe "return" do
    it "implements return from methods" do
      code =  File.read("#{interpreter_code}/return.awm")
      expect(Interpreter.new.eval(code).ruby_value).to eq(5)
    end
  end

  describe "full test" do
    it "prints" do
      code =  File.read("#{interpreter_code}/full_test.awm")
      expect {Interpreter.new.eval(code) }.to output("yeah\n").to_stdout
    end
  end
end
