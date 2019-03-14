# EN: State Design Pattern
#
# Intent: Lets an object alter its behavior when its internal state changes. It
# appears as if the object changed its class.
#
# RU: Паттерн Состояние
#
# Назначение: Позволяет объектам менять поведение в зависимости от своего
# состояния. Извне создаётся впечатление, что изменился класс объекта.

# EN: The Context defines the interface of interest to clients. It also
# maintains a reference to an instance of a State subclass, which represents
# the current state of the Context.
#
# RU: Контекст определяет интерфейс, представляющий интерес для клиентов. Он
# также хранит ссылку на экземпляр подкласса Состояния, который отображает
# текущее состояние Контекста.
#
# @abstract
class Context
  # EN: A reference to the current state of the Context.
  #
  # RU: Ссылка на текущее состояние Контекста.
  # @return [State]
  attr_accessor :state
  private :state

  # @param [State] state
  def initialize(state)
    transition_to(state)
  end

  # EN: The Context allows changing the State object at runtime.
  #
  # RU: Контекст позволяет изменять объект Состояния во время выполнения.
  #
  # @param [State] state
  def transition_to(state)
    puts "Context: Transition to #{state.class}"
    @state = state
    @state.context = self
  end

  # EN: The Context delegates part of its behavior to the current State object.
  #
  # RU: Контекст делегирует часть своего поведения текущему объекту Состояния.

  def request1
    @state.handle1
  end

  def request2
    @state.handle2
  end
end

# EN: The base State class declares methods that all Concrete State should
# implement and also provides a backreference to the Context object,
# associated with the State. This backreference can be used by States to
# transition the Context to another State.
#
# RU: Базовый класс Состояния объявляет методы, которые должны реализовать все
# Конкретные Состояния, а также предоставляет обратную ссылку на объект
# Контекст, связанный с Состоянием. Эта обратная ссылка может использоваться
# Состояниями для передачи Контекста другому Состоянию.
#
# @abstract
class State
  attr_accessor :context

  # @abstract
  def handle1
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  def handle2
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Concrete States implement various behaviors, associated with a state of the
# Context.
#
# RU: Конкретные Состояния реализуют различные модели поведения, связанные с
# состоянием Контекста.

class ConcreteStateA < State
  def handle1
    puts 'ConcreteStateA handles request1.'
    puts 'ConcreteStateA wants to change the state of the context.'
    @context.transition_to(ConcreteStateB.new)
  end

  def handle2
    puts 'ConcreteStateA handles request2.'
  end
end

class ConcreteStateB < State
  def handle1
    puts 'ConcreteStateB handles request1.'
  end

  def handle2
    puts 'ConcreteStateB handles request2.'
    puts 'ConcreteStateB wants to change the state of the context.'
    @context.transition_to(ConcreteStateA.new)
  end
end

# EN: The client code.
#
# RU: Клиентский код.

context = Context.new(ConcreteStateA.new)
context.request1
context.request2
