require 'spec_helper'

describe "Runtime" do

  it "gets a constant" do
    expect(Constants["Object"]).to_not eq(nil)
  end

  it "creates an object" do
    object = Constants["Object"].call("new")
    expect(Constants["Object"]).to eq(object.runtime_class)
  end

  it "creates an object mapped to a ruby value" do
    expect(Constants["Number"].new_with_value(32).ruby_value).to eq(32)
  end

  describe "looking up methods in a class" do
    context "when the method exists" do
      it "finds the method" do
        expect(Constants["Object"].lookup("print")).to_not eq(nil)
      end
    end

    context "when the method does not exist" do
      it "raises an exception" do
        expect { Constants["Object"].lookup("not_there")}.to raise_error(RuntimeError)
      end
    end
  end

  describe "calling methods" do
    it "calls the method" do
      object = Constants["Object"].call("new")
      expect(object.runtime_class).to eq(Constants["Object"])
    end
  end

  describe "class is a class" do
    it "has a class" do
      expect(Constants["Number"].runtime_class).to eq(Constants["Class"])
    end
  end
end
