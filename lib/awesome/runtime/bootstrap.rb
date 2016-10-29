Constants = {}

Constants["Class"] = AwesomeClass.new
Constants["Class"].runtime_class = Constants["Class"]
Constants["Object"] = AwesomeClass.new
Constants["Number"] = AwesomeClass.new
Constants["String"] = AwesomeClass.new

root_self = Constants["Object"].new
RootContext = Context.new(root_self)

Constants["TrueClass"] = AwesomeClass.new
Constants["FalseClass"] = AwesomeClass.new
Constants["NilClass"] = AwesomeClass.new

Constants["true"] = Constants["TrueClass"].new_with_value(true)
Constants["false"] = Constants["FalseClass"].new_with_value(false)
Constants["nil"] = Constants["NilClass"].new_with_value(nil)

Constants["Class"].def :new do |receiver, arguments|
  receiver.new
end

Constants["Object"].def :print do |receiver, arguments|
  puts arguments.first.ruby_value
  Constants["nil"]
end

NUMERICAL_OPERATORS = [
  "+", "-", "*", "/",
]

NUMERICAL_OPERATORS.each do |op|
  Constants["Number"].def op.to_sym do |receiver, arguments|
    result = receiver.ruby_value.send(op.to_sym, arguments.first.ruby_value)
    Constants["Number"].new_with_value(result)
  end
end

COMPARISON_OPERATORS = [
  ">", ">=", "<", "<=",
  "==", "!=",
]

COMPARISON_OPERATORS.each do |op|
  Constants["Number"].def op.to_sym do |receiver, arguments|
    result = receiver.ruby_value.send(op.to_sym, arguments.first.ruby_value)
    result ?  Constants["true"] : Constants["false"]
  end
end

Constants["TrueClass"].def '&&'.to_sym do|receiver,arguments|
  arguments.first.ruby_value ? Constants["true"] : Constants["false"]
end

Constants["FalseClass"].def '&&'.to_sym do|receiver,arguments|
  Constants["false"]
end

Constants["TrueClass"].def '||'.to_sym do|receiver,arguments|
  Constants["true"]
end

Constants["FalseClass"].def '||'.to_sym do|receiver,arguments|
  arguments.first.ruby_value ? Constants["true"] : Constants["false"]
end
