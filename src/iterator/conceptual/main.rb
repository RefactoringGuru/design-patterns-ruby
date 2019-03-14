# EN: Iterator Design Pattern
#
# Intent: Lets you traverse elements of a collection without exposing its
# underlying representation (list, stack, tree, etc.).
#
# RU: Паттерн Итератор
#
# Назначение: Даёт возможность последовательно обходить элементы составных
# объектов, не раскрывая их внутреннего представления.

class AlphabeticalOrderIterator
  # EN: In Ruby, the Enumerable mixin provides classes with several traversal
  # and searching methods, and with the ability to sort. The class must provide
  # a method each, which yields successive members of the collection.
  #
  # RU: Примесь Enumerable в Ruby предоставляет классы методами обхода, поиска и
  # сортировки значений. Класс, реализующий Enumerable должен определить метод
  # `each`, который возвращает (в yield) последовательно элементы коллекции.
  include Enumerable

  # EN: This attribute indicates the traversal direction.
  #
  # RU: Этот атрибут указывает направление обхода.
  # @return [Boolean]
  attr_accessor :reverse
  private :reverse

  # @return [Array]
  attr_accessor :collection
  private :collection

  # @param [Array] collection
  # @param [Boolean] reverse
  def initialize(collection, reverse = false)
    @collection = collection
    @reverse = reverse
  end

  def each(&block)
    return @collection.reverse.each(&block) if reverse

    @collection.each(&block)
  end
end

class WordsCollection
  # @return [Array]
  attr_accessor :collection
  private :collection

  def initialize(collection = [])
    @collection = collection
  end

  # EN: The `iterator` method returns the iterator object itself, by default
  # we return the iterator in ascending order.
  #
  # RU: Метод iterator возвращает объект итератора, по умолчанию мы
  # возвращаем итератор с сортировкой по возрастанию.
  #
  # @return [AlphabeticalOrderIterator]
  def iterator
    AlphabeticalOrderIterator.new(@collection)
  end

  # @return [AlphabeticalOrderIterator]
  def reverse_iterator
    AlphabeticalOrderIterator.new(@collection, true)
  end

  # @param [String] item
  def add_item(item)
    @collection << item
  end
end

# EN: The client code may or may not know about the Concrete Iterator or
# Collection classes, depending on the level of indirection you want to keep
# in your program.
#
# RU: Клиентский код может знать или не знать о Конкретном Итераторе или
# классах Коллекций, в зависимости от уровня косвенности, который вы хотите
# сохранить в своей программе.
collection = WordsCollection.new
collection.add_item('First')
collection.add_item('Second')
collection.add_item('Third')

puts 'Straight traversal:'
collection.iterator.each { |item| puts item }
puts "\n"

puts 'Reverse traversal:'
collection.reverse_iterator.each { |item| puts item }
