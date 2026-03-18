# frozen_string_literal: true

class Module
  def const_set_p(name, value)
    first, rest = name.to_s.split("::", 2)
    raise NameError, "wrong constant name " unless first
    return const_set(first, value)          unless rest

    submod =
      const_defined?(first, false) ? const_get(first, false) : const_set(first, Module.new)
    raise NameError, "#{self.name}::#{first} is not a Module or Class" unless submod.is_a?(Module)

    submod.const_set_p(rest, value)
  end
end
