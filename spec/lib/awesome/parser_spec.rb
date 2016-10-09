require 'spec_helper'

describe Parser do
  let(:code) {
<<-CODE
def method(a, b):
  true
CODE
}

let(:nodes) { Nodes.new(
  [
    DefNode.new("method", ["a", "b"],
      Nodes.new([TrueNode.new])
               )
  ])
}

 describe "#parse" do
   it "parses the code" do
     result = Parser.new.parse(code)
     expect(result).to eq(nodes)
   end
 end
end
