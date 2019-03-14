# EN: Prototype Design Pattern
#
# Intent: Lets you copy existing objects without making your code dependent on
# their classes.
#
# RU: Паттерн Прототип
#
# Назначение: Позволяет копировать объекты, не вдаваясь в подробности их
# реализации.

# EN: The example class that has cloning ability. We'll see how the values of
# field with different types will be cloned.
#
# RU: Пример класса, имеющего возможность клонирования. Мы посмотрим как
# происходит клонирование значений полей разных типов.
class Prototype
  attr_accessor :primitive, :component, :circular_reference

  def initialize
    @primitive = nil
    @component = nil
    @circular_reference = nil
  end

  # @return [Prototype]
  def clone
    @component = deep_copy(@component)

    # EN: Cloning an object that has a nested object with backreference
    # requires special treatment. After the cloning is completed, the nested
    # object should point to the cloned object, instead of the original
    # object.
    #
    # RU: Клонирование объекта, который имеет вложенный объект с обратной
    # ссылкой, требует специального подхода. После завершения клонирования
    # вложенный объект должен указывать на клонированный объект, а не на
    # исходный объект.
    @circular_reference = deep_copy(@circular_reference)
    @circular_reference.prototype = self
    deep_copy(self)
  end

  # @param [Object] object
  private def deep_copy(object)
    Marshal.load(Marshal.dump(object))
  end
end

class ComponentWithBackReference
  attr_accessor :prototype

  # @param [Prototype] prototype
  def initialize(prototype)
    @prototype = prototype
  end
end

# EN: The client code.
#
# RU: Клиентский код.
p1 = Prototype.new
p1.primitive = 245
p1.component = Time.now
p1.circular_reference = ComponentWithBackReference.new(p1)

p2 = p1.clone

if p1.primitive == p2.primitive
  puts 'Primitive field values have been carried over to a clone. Yay!'
else
  puts 'Primitive field values have not been copied. Booo!'
end

if p1.component.equal?(p2.component)
  puts 'Simple component has not been cloned. Booo!'
else
  puts 'Simple component has been cloned. Yay!'
end

if p1.circular_reference.equal?(p2.circular_reference)
  puts 'Component with back reference has not been cloned. Booo!'
else
  puts 'Component with back reference has been cloned. Yay!'
end

if p1.circular_reference.prototype.equal?(p2.circular_reference.prototype)
  print 'Component with back reference is linked to original object. Booo!'
else
  print 'Component with back reference is linked to the clone. Yay!'
end
