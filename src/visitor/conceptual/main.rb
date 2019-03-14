# EN: Visitor Design Pattern
#
# Intent: Lets you separate algorithms from the objects on which they operate.
#
# RU: Паттерн Посетитель
#
# Назначение: Позволяет создавать новые операции, не меняя классы объектов, над
# которыми эти операции могут выполняться.

# EN: The Component interface declares an `accept` method that should take the
# base visitor interface as an argument.
#
# RU: Интерфейс Компонента объявляет метод accept, который в качестве
# аргумента может получать любой объект, реализующий интерфейс посетителя.
class Component
  # @abstract
  #
  # @param [Visitor] visitor
  def accept(_visitor)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Each Concrete Component must implement the `accept` method in such a way
# that it calls the visitor's method corresponding to the component's class.
#
# RU: Каждый Конкретный Компонент должен реализовать метод accept таким
# образом, чтобы он вызывал метод посетителя, соответствующий классу
# компонента.
class ConcreteComponentA < Component
  # EN: Note that we're calling `visitConcreteComponentA`, which matches the
  # current class name. This way we let the visitor know the class of the
  # component it works with.
  #
  # RU: Обратите внимание, мы вызываем visitConcreteComponentA, что
  # соответствует названию текущего класса. Таким образом мы позволяем
  # посетителю узнать, с каким классом компонента он работает.
  #
  # @param [Visitor] visitor
  def accept(visitor)
    visitor.visit_concrete_component_a(self)
  end

  # EN: Concrete Components may have special methods that don't exist in
  # their base class or interface. The Visitor is still able to use these
  # methods since it's aware of the component's concrete class.
  #
  # RU: Конкретные Компоненты могут иметь особые методы, не объявленные в их
  # базовом классе или интерфейсе. Посетитель всё же может использовать эти
  # методы, поскольку он знает о конкретном классе компонента.
  def exclusive_method_of_concrete_component_a
    'A'
  end
end

# EN: Same here: visit_concrete_component_b => ConcreteComponentB
#
# RU: То же самое здесь: visit_concrete_component_b => ConcreteComponentB
class ConcreteComponentB < Component
  # @param [Visitor] visitor
  def accept(visitor)
    visitor.visit_concrete_component_b(self)
  end

  def special_method_of_concrete_component_b
    'B'
  end
end

# EN: The Visitor Interface declares a set of visiting methods that correspond
# to component classes. The signature of a visiting method allows the visitor
# to identify the exact class of the component that it's dealing with.
#
# RU: Интерфейс Посетителя объявляет набор методов посещения, соответствующих
# классам компонентов. Сигнатура метода посещения позволяет посетителю
# определить конкретный класс компонента, с которым он имеет дело.
#
# @abstract
class Visitor
  # @abstract
  #
  # @param [ConcreteComponentA] element
  def visit_concrete_component_a(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  #
  # @param [ConcreteComponentB] element
  def visit_concrete_component_b(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Concrete Visitors implement several versions of the same algorithm, which
# can work with all concrete component classes.
#
# You can experience the biggest benefit of the Visitor pattern when using it with
# a complex object structure, such as a Composite tree. In this case, it might be
# helpful to store some intermediate state of the algorithm while executing
# visitor's methods over various objects of the structure.
#
# RU: Конкретные Посетители реализуют несколько версий одного и того же алгоритма,
# которые могут работать со всеми классами конкретных компонентов.
#
# Максимальную выгоду от паттерна Посетитель вы почувствуете, используя его со
# сложной структурой объектов, такой как дерево Компоновщика. В этом случае было
# бы полезно хранить некоторое промежуточное состояние алгоритма при выполнении
# методов посетителя над различными объектами структуры.
class ConcreteVisitor1 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

class ConcreteVisitor2 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

# EN: The client code can run visitor operations over any set of elements
# without figuring out their concrete classes. The accept operation directs a
# call to the appropriate operation in the visitor object.
#
# RU: Клиентский код может выполнять операции посетителя над любым набором
# элементов, не выясняя их конкретных классов. Операция принятия направляет
# вызов к соответствующей операции в объекте посетителя.
#
# @param [Array<Component>] components
# @param [Visitor] visitor
def client_code(components, visitor)
  # ...
  components.each do |component|
    component.accept(visitor)
  end
  # ...
end

components = [ConcreteComponentA.new, ConcreteComponentB.new]

puts 'The client code works with all visitors via the base Visitor interface:'
visitor1 = ConcreteVisitor1.new
client_code(components, visitor1)

puts 'It allows the same client code to work with different types of visitors:'
visitor2 = ConcreteVisitor2.new
client_code(components, visitor2)
