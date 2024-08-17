# typed: true
require 'sorbet-runtime'

# EN: Abstract Factory assumes that you have several families of products,
# structured into separate class hierarchies (Button/Checkbox). All products of
# the same family have the common interface.
#
# This is the common interface for buttons family.
#
# RU: Паттерн предполагает, что у вас есть несколько семейств продуктов,
# находящихся в отдельных иерархиях классов (Button/Checkbox). Продукты одного
# семейства должны иметь общий интерфейс.
#
# Это — общий интерфейс для семейства продуктов кнопок.
#
class Button
  extend T::Sig

  sig { void }
  def draw
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: All products families have the same varieties (MacOS/Windows).
#
# This is a MacOS variant of a button.
#
# RU: Все семейства продуктов имеют одни и те же вариации (MacOS/Windows).
#
# Это вариант кнопки под MacOS.
#
class MacOSButton < Button
  extend T::Sig

  sig { override.void }
  def draw
    puts 'MacOSButton has been drawn'
  end
end

# EN: This is a Windows variant of a button.
#
# RU: Это вариант кнопки под Windows.
#
class WindowsButton < Button
  extend T::Sig

  sig { override.void }
  def draw
    puts 'WindowsButton has been drawn'
  end
end

# EN: Checkboxes is the second product family. It has the same variants as
# buttons.
#
# RU: Чекбоксы — это второе семейство продуктов. Оно имеет те же вариации, что
# и кнопки.
#
class Checkbox
  extend T::Sig

  sig { void }
  def draw
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: This is a MacOS variant of a checkbox.
#
# RU: Вариация чекбокса под MacOS.
#
class MacOSCheckbox < Checkbox
  extend T::Sig

  sig { override.void }
  def draw
    puts 'MacOSCheckbox has been drawn'
  end
end

# EN: This is a Windows variant of a checkbox.
#
# RU: Вариация чекбокса под Windows.
#
class WindowsCheckbox < Checkbox
  extend T::Sig

  sig { override.void }
  def draw
    puts 'WindowsCheckbox has been drawn'
  end
end

# EN: This is an example of abstract factory.
#
# RU: Это пример абстрактной фабрики.
#
class GUIFactory
  extend T::Sig

  sig { void }
  def create_button
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end

  sig { void }
  def create_checkbox
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end
end

# EN: This is a MacOS concrete factory
#
# RU: Это бетонный завод MacOS
#
class MacOSFactory < GUIFactory
  extend T::Sig

  sig { override.returns(MacOSButton) }
  def create_button
    MacOSButton.new
  end

  sig { override.returns(MacOSCheckbox) }
  def create_checkbox
    MacOSCheckbox.new
  end
end

# EN: This is a Windwows concrete factory
#
# RU: Это бетонный завод Windwows
#
class WindowsFactory < GUIFactory
  extend T::Sig

  sig { override.returns(WindowsButton) }
  def create_button
    WindowsButton.new
  end

  sig { override.returns(WindowsCheckbox) }
  def create_checkbox
    WindowsCheckbox.new
  end
end

# EN: Factory users don't care which concrete factory they use since they work
# with factories and products through abstract interfaces.
#
# RU: Код, использующий фабрику, не волнует с какой конкретно фабрикой он
# работает. Все получатели продуктов работают с продуктами через абстрактный
# интерфейс.
#
class Application
  extend T::Sig

  sig { params(factory: T.nilable(T.any(MacOSFactory, WindowsFactory))).void }
  def initialize(factory)
    @button = T.must(factory).create_button
    @checkbox = T.must(factory).create_checkbox
  end

  sig { void }
  def draw
    @button.draw
    @checkbox.draw
  end
end

# EN: This is an example of usage in a real application.
# If the OS is MacOS we can ask the Application to draw using the MacOSFactory,
# otherwise, if the OS is Windows we can pass the WindowsFactory instead.
#
# RU:Это пример использования в реальном приложении.
# Если ОС MacOS, мы можем попросить приложение рисовать с помощью MacOSFactory,
# в противном случае, если ОС — Windows, мы можем вместо этого передать
# WindowsFactory.
#
current_os = 'Windows'
factory = nil

case current_os
when 'MacOS'
  factory = MacOSFactory.new
when 'Windows'
  factory = WindowsFactory.new
end
Application.new(factory).draw
