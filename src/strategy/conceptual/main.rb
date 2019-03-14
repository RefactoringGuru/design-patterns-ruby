# EN: Strategy Design Pattern
#
# Intent: Lets you define a family of algorithms, put each of them into a separate
# class, and make their objects interchangeable.
#
# RU: Паттерн Стратегия
#
# Назначение: Определяет семейство схожих алгоритмов и помещает каждый из них в
# собственный класс, после чего алгоритмы можно взаимозаменять прямо во время
# исполнения программы.

# EN: The Context defines the interface of interest to clients.
#
# RU: Контекст определяет интерфейс, представляющий интерес для клиентов.
class Context
  # EN: The Context maintains a reference to one of the Strategy objects.
  # The Context does not know the concrete class of a strategy. It should
  # work with all strategies via the Strategy interface.
  #
  # RU: Контекст хранит ссылку на один из объектов Стратегии. Контекст не
  # знает конкретного класса стратегии. Он должен работать со всеми
  # стратегиями через интерфейс Стратегии.
  # @return [Strategy]
  attr_writer :strategy

  # EN: Usually, the Context accepts a strategy through the constructor, but
  # also provides a setter to change it at runtime.
  #
  # RU: Обычно Контекст принимает стратегию через конструктор, а также
  # предоставляет сеттер для её изменения во время выполнения.
  #
  # @param [Strategy] strategy
  def initialize(strategy)
    @strategy = strategy
  end

  # EN: Usually, the Context allows replacing a Strategy object at runtime.
  #
  # RU: Обычно Контекст позволяет заменить объект Стратегии во время
  # выполнения.
  #
  # @param [Strategy] strategy
  def strategy=(strategy)
    @strategy = strategy
  end

  # EN: The Context delegates some work to the Strategy object instead of
  # implementing multiple versions of the algorithm on its own.
  #
  # RU: Вместо того, чтобы самостоятельно реализовывать множественные версии
  # алгоритма, Контекст делегирует некоторую работу объекту Стратегии.
  def do_some_business_logic
    # ...

    puts 'Context: Sorting data using the strategy (not sure how it\'ll do it)'
    result = @strategy.do_algorithm(%w[a b c d e])
    print result.join(',')

    # ...
  end
end

# EN: The Strategy interface declares operations common to all supported
# versions of some algorithm.
#
# The Context uses this interface to call the algorithm defined by Concrete
# Strategies.
#
# RU: Интерфейс Стратегии объявляет операции, общие для всех поддерживаемых
# версий некоторого алгоритма.
#
# Контекст использует этот интерфейс для вызова алгоритма, определённого
# Конкретными Стратегиями.
#
# @abstract
class Strategy
  # @abstract
  #
  # @param [Array] data
  def do_algorithm(_data)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Concrete Strategies implement the algorithm while following the base
# Strategy interface. The interface makes them interchangeable in the Context.
#
# RU: Конкретные Стратегии реализуют алгоритм, следуя базовому интерфейсу
# Стратегии. Этот интерфейс делает их взаимозаменяемыми в Контексте.

class ConcreteStrategyA < Strategy
  # @param [Array] data
  #
  # @return [Array]
  def do_algorithm(data)
    data.sort
  end
end

class ConcreteStrategyB < Strategy
  # @param [Array] data
  #
  # @return [Array]
  def do_algorithm(data)
    data.sort.reverse
  end
end

# EN: The client code picks a concrete strategy and passes it to the
# context. The client should be aware of the differences between strategies
# in order to make the right choice.
#
# RU: Клиентский код выбирает конкретную стратегию и передаёт её в контекст.
# Клиент должен знать о различиях между стратегиями, чтобы сделать
# правильный выбор.

context = Context.new(ConcreteStrategyA.new)
puts 'Client: Strategy is set to normal sorting.'
context.do_some_business_logic
puts "\n\n"

puts 'Client: Strategy is set to reverse sorting.'
context.strategy = ConcreteStrategyB.new
context.do_some_business_logic
