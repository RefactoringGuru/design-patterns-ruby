# EN: Observer Design Pattern
#
# Intent: Lets you define a subscription mechanism to notify multiple objects
# about any events that happen to the object they're observing.
#
# Note that there's a lot of different terms with similar meaning associated with
# this pattern. Just remember that the Subject is also called the Publisher and
# the Observer is often called the Subscriber and vice versa. Also the verbs
# "observe", "listen" or "track" usually mean the same thing.
#
# RU: Паттерн Наблюдатель
#
# Назначение: Создаёт механизм подписки, позволяющий одним объектам следить и
# реагировать на события, происходящие в других объектах.
#
# Обратите внимание, что существует множество различных терминов с похожими
# значениями, связанных с этим паттерном. Просто помните, что Субъекта также
# называют Издателем, а Наблюдателя часто называют Подписчиком и наоборот. Также
# глаголы «наблюдать», «слушать» или «отслеживать» обычно означают одно и то же.

# EN: The Subject interface declares a set of methods for managing
# subscribers.
#
# RU: Интферфейс издателя объявляет набор методов для управлениями
# подписчиками.
#
# @abstract
class Subject
  # EN: Attach an observer to the subject.
  #
  # RU: Присоединяет наблюдателя к издателю.
  #
  # @abstract
  #
  # @param [Observer] observer
  def attach(observer)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # EN: Detach an observer from the subject.
  #
  # RU: Отсоединяет наблюдателя от издателя.
  #
  # @abstract
  #
  # @param [Observer] observer
  def detach(observer)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  # EN: Notify all observers about an event.
  #
  # RU: Уведомляет всех наблюдателей о событии.
  #
  # @abstract
  def notify
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: The Subject owns some important state and notifies observers when the
# state changes.
#
# RU: Издатель владеет некоторым важным состоянием и оповещает наблюдателей о
# его изменениях.
class ConcreteSubject < Subject
  # EN: For the sake of simplicity, the Subject's state, essential to all
  # subscribers, is stored in this variable.
  #
  # RU: Для удобства в этой переменной хранится состояние Издателя, необходимое
  # всем подписчикам.
  attr_accessor :state

  # @!attribute observers
  #   @return [Array<Observer>]
  # attr_accessor :observers
  # private :observers

  def initialize
    @observers = []
  end

  # EN: List of subscribers. In real life, the list of subscribers can be stored
  # more comprehensively (categorized by event type, etc.).
  #
  # RU: Список подписчиков. В реальной жизни список подписчиков может храниться
  # в более подробном виде (классифицируется по типу события и т.д.)

  # @param [Obserser] observer
  def attach(observer)
    puts 'Subject: Attached an observer.'
    @observers << observer
  end

  # @param [Obserser] observer
  def detach(observer)
    @observers.delete(observer)
  end

  # EN: The subscription management methods.
  #
  # RU: Методы управления подпиской.

  # EN: Trigger an update in each subscriber.
  #
  # RU: Запуск обновления в каждом подписчике.
  def notify
    puts 'Subject: Notifying observers...'
    @observers.each { |observer| observer.update(self) }
  end

  # EN: Usually, the subscription logic is only a fraction of what a Subject
  # can really do. Subjects commonly hold some important business logic,
  # that triggers a notification method whenever something important is
  # about to happen (or after it).
  #
  # RU: Обычно логика подписки – только часть того, что делает Издатель.
  # Издатели часто содержат некоторую важную бизнес-логику, которая
  # запускает метод уведомления всякий раз, когда должно произойти что-то
  # важное (или после этого).
  def some_business_logic
    puts "\nSubject: I'm doing something important."
    @state = rand(0..10)

    puts "Subject: My state has just changed to: #{@state}"
    notify
  end
end

# EN: The Observer interface declares the update method, used by subjects.
#
# RU: Интерфейс Наблюдателя объявляет метод уведомления, который издатели
# используют для оповещения своих подписчиков.
#
# @abstract
class Observer
  # EN: Receive update from subject.
  #
  # RU: Получить обновление от субъекта.
  #
  # @abstract
  #
  # @param [Subject] subject
  def update(_subject)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: Concrete Observers react to the updates issued by the Subject they had been
# attached to.
#
# RU: Конкретные Наблюдатели реагируют на обновления, выпущенные Издателем, к
# которому они прикреплены.

class ConcreteObserverA < Observer
  # @param [Subject] subject
  def update(subject)
    puts 'ConcreteObserverA: Reacted to the event' if subject.state < 3
  end
end

class ConcreteObserverB < Observer
  # @param [Subject] subject
  def update(subject)
    return unless subject.state.zero? || subject.state >= 2

    puts 'ConcreteObserverB: Reacted to the event'
  end
end

# EN: The client code.
#
# RU: Клиентский код.

subject = ConcreteSubject.new

observer_a = ConcreteObserverA.new
subject.attach(observer_a)

observer_b = ConcreteObserverB.new
subject.attach(observer_b)

subject.some_business_logic
subject.some_business_logic

subject.detach(observer_a)

subject.some_business_logic
