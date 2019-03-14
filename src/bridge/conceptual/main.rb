# EN: Bridge Design Pattern
#
# Intent: Lets you split a large class or a set of closely related classes into
# two separate hierarchies—abstraction and implementation—which can be developed
# independently of each other.
#
#               A
#            /     \                        A         N
#          Aa      Ab        ===>        /     \     / \
#         / \     /  \                 Aa(N) Ab(N)  1   2
#       Aa1 Aa2  Ab1 Ab2
#
# RU: Паттерн Мост
#
# Назначение: Разделяет один или несколько классов на две отдельные иерархии —
# абстракцию и реализацию, позволяя изменять их независимо друг от друга.
#
#               A
#            /     \                        A         N
#          Aa      Ab        ===>        /     \     / \
#         / \     /  \                 Aa(N) Ab(N)  1   2
#       Aa1 Aa2  Ab1 Ab2

# EN: The Abstraction defines the interface for the "control" part of the two
# class hierarchies. It maintains a reference to an object of the
# Implementation hierarchy and delegates all of the real work to this object.
#
# RU: Абстракция устанавливает интерфейс для «управляющей» части двух иерархий
# классов. Она содержит ссылку на объект из иерархии Реализации и делегирует
# ему всю настоящую работу.
class Abstraction
  # @param [Implementation] implementation
  def initialize(implementation)
    @implementation = implementation
  end

  # @return [String]
  def operation
    "Abstraction: Base operation with:\n"\
    "#{@implementation.operation_implementation}"
  end
end

# EN: You can extend the Abstraction without changing the Implementation
# classes.
#
# RU: Можно расширить Абстракцию без изменения классов Реализации.
class ExtendedAbstraction < Abstraction
  # @return [String]
  def operation
    "ExtendedAbstraction: Extended operation with:\n"\
    "#{@implementation.operation_implementation}"
  end
end

# EN: The Implementation defines the interface for all implementation classes.
# It doesn't have to match the Abstraction's interface. In fact, the two
# interfaces can be entirely different. Typically the Implementation interface
# provides only primitive operations, while the Abstraction defines higher-
# level operations based on those primitives.
#
# RU: Реализация устанавливает интерфейс для всех классов реализации. Он не
# должен соответствовать интерфейсу Абстракции. На практике оба интерфейса
# могут быть совершенно разными. Как правило, интерфейс Реализации
# предоставляет только примитивные операции, в то время как Абстракция
# определяет операции более высокого уровня, основанные на этих примитивах.
#
# @abstract
class Implementation
  # @abstract
  #
  # @return [String]
  def operation_implementation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Each Concrete Implementation corresponds to a specific platform and
# implements the Implementation interface using that platform's API.
#
# RU: Каждая Конкретная Реализация соответствует определённой платформе и
# реализует интерфейс Реализации с использованием API этой платформы.
class ConcreteImplementationA < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationA: Here\'s the result on the platform A.'
  end
end

class ConcreteImplementationB < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationB: Here\'s the result on the platform B.'
  end
end

# EN: Except for the initialization phase, where an Abstraction object gets
# linked with a specific Implementation object, the client code should only
# depend on the Abstraction class. This way the client code can support any
# abstraction-implementation combination.
#
# RU: За исключением этапа инициализации, когда объект Абстракции связывается
# с определённым объектом Реализации, клиентский код должен зависеть только от
# класса Абстракции. Таким образом, клиентский код может поддерживать любую
# комбинацию абстракции и реализации.
#
# @param [Abstraction] abstraction
def client_code(abstraction)
  # ...

  print abstraction.operation

  # ...
end

# EN: The client code should be able to work with any pre-configured
# abstraction-implementation combination.
#
# RU: Клиентский код должен работать с любой предварительно сконфигурированной
# комбинацией абстракции и реализации.

implementation = ConcreteImplementationA.new
abstraction = Abstraction.new(implementation)
client_code(abstraction)

puts "\n\n"

implementation = ConcreteImplementationB.new
abstraction = ExtendedAbstraction.new(implementation)
client_code(abstraction)
