class Interpreter
  def initialize
    @parser = Parser.new
  end

  def eval(code)
    @parser.parse(code).eval(RootContext)
  end
end

class Nodes
  def eval(context)
    return_value = nil
    nodes.each do |node|
      return_value = node.eval(context)
    end

    return_value || Constants["nil"]
  end
end

class NumberNode
  def eval(context)
    Constants["Number"].new_with_value(value)
  end
end

class StringNode
  def eval(context)
    Constants["String"].new_with_value(value)
  end
end

class TrueNode
  def eval(context)
    Constants["true"]
  end
end

class FalseNode
  def eval(context)
    Constants["false"]
  end
end

class NilNode
  def eval(context)
    Constants["nil"]
  end
end

class GetConstantNode
  def eval(context)
    Constants[name]
  end
end

class GetLocalNode
  def eval(context)
    context.locals[name]
  end
end

class SetConstantNode
  def eval(context)
    Constants[name] = value.eval(context)
  end
end

class SetLocalNode
  def eval(context)
    context.locals[name] = value.eval(context)
  end
end

class CallNode
  def eval(context)
    callee(context).call(method, evaluated_arguments(context))
  rescue ReturnNode::ReturnValue => e
    return e.value
  end

  def evaluated_arguments(context)
    arguments.map { |arg| arg.eval(context) }
  end

  def callee(context)
    receiver ? receiver.eval(context) : context.current_self
  end
end

class DefNode
  def eval(context)
    method = AwesomeMethod.new(params, body)
    context.current_class.runtime_methods[name] = method
  end
end

class ClassNode
  def eval(context)
    awesome_class = Constants[name]

    unless awesome_class
      awesome_class = AwesomeClass.new
      Constants[name] = awesome_class
    end

    class_context = Context.new(awesome_class, awesome_class)
    body.eval(class_context)

    awesome_class
  end
end

class IfNode
  def eval(context)
    if condition.eval(context).ruby_value
      body.eval(context)
    elsif elsebody
      elsebody.eval(context)
    else
      Constants["nil"]
    end
  end
end

class WhileNode
  def eval(context)
    while condition.eval(context).ruby_value
      body.eval(context)
    end
    Constants["nil"]
  end
end

class ReturnNode
  class ReturnValue < StandardError
    attr_reader :value
    def initialize(message, value)
      @value = value
      super message
    end
  end

  def eval(context)
    fail ReturnValue.new("Returning", self.value.eval(context))
  end
end
