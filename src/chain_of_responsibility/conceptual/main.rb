# EN: Chain of Responsibility Design Pattern
#
# Intent: Lets you pass requests along a chain of handlers. Upon receiving a
# request, each handler decides either to process the request or to pass it to the
# next handler in the chain.
#
# RU: Паттерн Цепочка обязанностей
#
# Назначение: Позволяет передавать запросы последовательно по цепочке
# обработчиков. Каждый последующий обработчик решает, может ли он обработать
# запрос сам и стоит ли передавать запрос дальше по цепи.

# EN: The Handler interface declares a method for building the chain of
# handlers. It also declares a method for executing a request.
#
# RU: Интерфейс Обработчика объявляет метод построения цепочки обработчиков.
# Он также объявляет метод для выполнения запроса.
#
# @abstract
class Handler
  # @abstract
  #
  # @param [Handler] handler
  def next_handler=(handler)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # @abstract
  #
  # @param [String] request
  #
  # @return [String, nil]
  def handle(request)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: The default chaining behavior can be implemented inside a base handler
# class.
#
# RU: Поведение цепочки по умолчанию может быть реализовано внутри базового
# сса обработчика.
class AbstractHandler < Handler
  # @return [Handler]
  attr_writer :next_handler

  # @param [Handler] handler
  #
  # @return [Handler]
  def next_handler(handler)
    @next_handler = handler
    # EN: Returning a handler from here will let us link handlers in a
    # convenient way like this:
    # monkey.next_handler(squirrel).next_handler(dog)
    #
    # RU: Возврат обработчика отсюда позволит связать обработчики простым
    # способом, вот так:
    # monkey.next_handler(squirrel).next_handler(dog)
    handler
  end

  # @abstract
  #
  # @param [String] request
  #
  # @return [String, nil]
  def handle(request)
    return @next_handler.handle(request) if @next_handler

    nil
  end
end

# EN: All Concrete Handlers either handle a request or pass it to the next handler
# in the chain.
#
# RU: Все Конкретные Обработчики либо обрабатывают запрос, либо передают его
# следующему обработчику в цепочке.
class MonkeyHandler < AbstractHandler
  # @param [String] request
  #
  # @return [String, nil]
  def handle(request)
    if request == 'Banana'
      "Monkey: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

class SquirrelHandler < AbstractHandler
  # @param [String] request
  #
  # @return [String, nil]
  def handle(request)
    if request == 'Nut'
      "Squirrel: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

class DogHandler < AbstractHandler
  # @param [String] request
  #
  # @return [String, nil]
  def handle(request)
    if request == 'MeatBall'
      "Dog: I'll eat the #{request}"
    else
      super(request)
    end
  end
end

# EN: The client code is usually suited to work with a single handler. In most
# cases, it is not even aware that the handler is part of a chain.
#
# RU: Обычно клиентский код приспособлен для работы с единственным
# обработчиком. В большинстве случаев клиенту даже неизвестно, что этот
# обработчик является частью цепочки.
#
# @param [Handler] handler
def client_code(handler)
  ['Nut', 'Banana', 'Cup of coffee'].each do |food|
    puts "\nClient: Who wants a #{food}?"
    result = handler.handle(food)
    if result
      print "  #{result}"
    else
      print "  #{food} was left untouched."
    end
  end
end

monkey = MonkeyHandler.new
squirrel = SquirrelHandler.new
dog = DogHandler.new

monkey.next_handler(squirrel).next_handler(dog)

# EN: The client should be able to send a request to any handler, not just
# the first one in the chain.
#
# RU: Клиент должен иметь возможность отправлять запрос любому обработчику,
# а не только первому в цепочке.
puts 'Chain: Monkey > Squirrel > Dog'
client_code(monkey)
puts "\n\n"

puts 'Subchain: Squirrel > Dog'
client_code(squirrel)
