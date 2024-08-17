# EN: Singleton Design Pattern
#
# Intent: Lets you ensure that a class has only one instance, while providing a
# global access point to this instance.
#
# RU: Паттерн Одиночка
#
# Назначение: Гарантирует, что у класса есть только один экземпляр, и
# предоставляет к нему глобальную точку доступа.

# EN: The Singleton class defines the `instance` method that lets clients
# access the unique singleton instance.
#
# RU: Класс Одиночка предоставляет метод instance, который позволяет
# клиентам получить доступ к уникальному экземпляру одиночки.
class SingletonCustom
  @instance = new

  private_class_method :new

  # EN: The static method that controls the access to the singleton
  # instance.
  #
  # This implementation let you subclass the Singleton class while keeping
  # just one instance of each subclass around.
  #
  # RU: Статический метод, управляющий доступом к экземпляру одиночки.
  #
  # Эта реализация позволяет вам расширять класс Одиночки, сохраняя повсюду
  # только один экземпляр каждого подкласса.
  def self.instance
    @instance
  end

  # EN: Finally, any singleton should define some business logic, which can
  # be executed on its instance.
  #
  # RU: Наконец, любой одиночка должен содержать некоторую бизнес-логику,
  # которая может быть выполнена на его экземпляре.
  def some_business_logic
    # ...
  end
end

# EN: The client code.
#
# RU: Клиентский код.

s1 = SingletonCustom.instance
s2 = SingletonCustom.instance

if s1.equal?(s2)
  print 'Singleton works, both variables contain the same instance.'
else
  print 'Singleton failed, variables contain different instances.'
end
