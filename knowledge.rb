def attribute(args, &block)

  if args.class == Hash
    arg = args.keys[0]
  else
    arg = args
  end

  define_method("#{arg}=") do |value|
    instance_variable_set("@#{arg}", value)
  end

  define_method("#{arg}?") do
    send(arg)
  end

  define_method(arg) do
    unless instance_variable_defined?("@#{arg}")
      instance_variable_set("@#{arg}", instance_eval(&block)) if block_given?
      instance_variable_set("@#{arg}", args.values[0]) if args.class == Hash
    end
    instance_variable_get("@#{arg}")
  end
end