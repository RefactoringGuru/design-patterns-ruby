# EN: Factory Method Design Pattern
#
# Intent: Provides an interface for creating objects in a superclass, but allows
# subclasses to alter the type of objects that will be created.
#
# RU: Паттерн Фабричный Метод
#
# Назначение: Определяет общий интерфейс для создания объектов в суперклассе,
# позволяя подклассам изменять тип создаваемых объектов.

# EN: The Creator class declares the factory method that is supposed to return
# an object of a Product class. The Creator's subclasses usually provide the
# implementation of this method.
#
# RU: Класс Создатель объявляет фабричный метод, который должен возвращать
# объект класса Продукт. Подклассы Создателя обычно предоставляют реализацию
# этого метода.
#
# @abstract
class Creator
  # EN: Note that the Creator may also provide some default implementation
  # of the factory method.
  #
  # RU: Обратите внимание, что Создатель может также обеспечить реализацию
  # фабричного метода по умолчанию.
  #
  # @abstract
  def factory_method
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # EN: Also note that, despite its name, the Creator's primary
  # responsibility is not creating products. Usually, it contains some core
  # business logic that relies on Product objects, returned by the factory
  # method. Subclasses can indirectly change that business logic by
  # overriding the factory method and returning a different type of product
  # from it.
  #
  # RU: Также заметьте, что, несмотря на название, основная обязанность
  # Создателя не заключается в создании продуктов. Обычно он содержит
  # некоторую базовую бизнес-логику, которая основана на объектах Продуктов,
  # возвращаемых фабричным методом. Подклассы могут косвенно изменять эту
  # бизнес-логику, переопределяя фабричный метод и возвращая из него другой
  # тип продукта.
  #
  # @return [String]
  def some_operation
    # EN: Call the factory method to create a Product object.
    #
    # RU: Вызываем фабричный метод, чтобы получить объект-продукт.
    product = factory_method

    # EN: Now, use the product.
    #
    # RU: Далее, работаем с этим продуктом.
    result = "Creator: The same creator's code has just worked with #{product.operation}"

    result
  end
end

# EN: Concrete Creators override the factory method in order to change the
# resulting product's type.
#
# RU: Конкретные Создатели переопределяют фабричный метод для того, чтобы изменить
# тип результирующего продукта.
class ConcreteCreator1 < Creator
  # EN: Note that the signature of the method still uses the abstract product
  # type, even though the concrete product is actually returned from the method.
  # This way the Creator can stay independent of concrete product classes.
  #
  # RU: Обратите внимание, что сигнатура метода по-прежнему использует тип
  # абстрактного продукта, хотя фактически из метода возвращается конкретный
  # продукт. Таким образом, Создатель может оставаться независимым от конкретных
  # классов продуктов.
  #
  # @return [ConcreteProduct1]
  def factory_method
    ConcreteProduct1.new
  end
end

class ConcreteCreator2 < Creator
  # @return [ConcreteProduct2]
  def factory_method
    ConcreteProduct2.new
  end
end

# EN: The Product interface declares the operations that all concrete products
# must implement.
#
# RU: Интерфейс Продукта объявляет операции, которые должны выполнять все
# конкретные продукты.
#
# @abstract
class Product
  # return [String]
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Concrete Products provide various implementations of the Product interface.
#
# RU: Конкретные Продукты предоставляют различные реализации интерфейса Продукта.
class ConcreteProduct1 < Product
  # @return [String]
  def operation
    '{Result of the ConcreteProduct1}'
  end
end

class ConcreteProduct2 < Product
  # @return [String]
  def operation
    '{Result of the ConcreteProduct2}'
  end
end

# EN: The client code works with an instance of a concrete creator, albeit
# through its base interface. As long as the client keeps working with the
# creator via the base interface, you can pass it any creator's subclass.
#
# RU: Клиентский код работает с экземпляром конкретного создателя, хотя и
# через его базовый интерфейс. Пока клиент продолжает работать с создателем
# через базовый интерфейс, вы можете передать ему любой подкласс создателя.
#
# @param [Creator] creator
def client_code(creator)
  print "Client: I'm not aware of the creator's class, but it still works.\n"\
        "#{creator.some_operation}"
end

puts 'App: Launched with the ConcreteCreator1.'
client_code(ConcreteCreator1.new)
puts "\n\n"

puts 'App: Launched with the ConcreteCreator2.'
client_code(ConcreteCreator2.new)
