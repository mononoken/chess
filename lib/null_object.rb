# frozen_string_literal: true

# Used for NullObject design pattern
class NullObject
  def method_missing(method, *args, &block)
    respond_to?(method) ? nil : super
  end

  def respond_to_missing?(_name, _include_private = false)
    true
  end
end
