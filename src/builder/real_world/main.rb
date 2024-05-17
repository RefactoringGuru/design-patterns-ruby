# EN: Pizza is the product that the builder class is going to be building
#
# RU: Pizza - это продукт, который будет строить класс строителей
#
class Pizza
  attr_accessor :toppings

  def initialize(crust)
    @crust = crust
    @toppings = []
  end

  def present
    puts 'This pizza is a'
    puts "#{@crust} pizza"
    puts 'with:'
    puts @toppings.join("\n")
    puts '-*-*--*--*--*--*--*-'
  end
end

# EN: PizzaBuilder is an abstract interface that allows us to add toppings to
# the pizza.
#
# RU: PizzaBuilder - это абстрактный интерфейс, который позволяет нам добавлять
# начинки в пиццу.
#
class PizzaBuilder
  attr_reader :pizza

  def add_tomato_sauce
    @pizza.toppings << 'Tomato sauce'
    self
  end

  def add_cheese
    @pizza.toppings << 'Cheese'
    self
  end

  def add_basil
    @pizza.toppings << 'Basil'
    self
  end

  def add_pepperoni
    @pizza.toppings << 'Pepperoni'
    self
  end
end

# EN: ThinCrustPizzaBuilder and StuffedCrustPizzaBuilder are the concrete
# builder classes used to build pizzas with specific crust types.
#
# RU: ThinCrustpizzabuilder и FackedCrustpizzabuilder - это бетонные классы,
# используемые для строительства пиццы с определенными типами коров.
#
class ThinCrustPizzaBuilder < PizzaBuilder
  def initialize
    @pizza = Pizza.new('Thin crust')
  end
end

class StuffedCrustPizzaBuilder < PizzaBuilder
  def initialize
    @pizza = Pizza.new('Stuffed crust')
  end
end

# EN: The Chef class act as the Director using the builder provided to make the
# pizzas that are requested.
#
# RU: Класс Chef -повара действует в качестве директора, использующего
# застройщика, предоставленного для изготовления запрашиваемой пиццы.
#
class Chef
  attr_accessor :builder

  def make_margherita_pizza
    @builder.add_tomato_sauce
            .add_cheese
            .add_basil
  end

  def make_pepperoni_pizza
    @builder.add_tomato_sauce
            .add_cheese
            .add_pepperoni
  end
end

# EN: This is an example in the real world
#
# RU: Это пример в реальном мире
#
chef = Chef.new

thin_crust_builder = ThinCrustPizzaBuilder.new
chef.builder = thin_crust_builder
chef.make_margherita_pizza
thin_crust_builder.pizza.present

stuffed_crust_builder = StuffedCrustPizzaBuilder.new
chef.builder = stuffed_crust_builder
chef.make_pepperoni_pizza
stuffed_crust_builder.pizza.present
