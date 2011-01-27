RSpec::Matchers.define :include_module do |module_name|
  match do |model|
    model.class.include? module_name
  end
end

RSpec::Matchers.define :have_defined_method do |method|
  match do |mod|
    mod.method_defined? method
  end
end