# EN: Imagine you work on an application that checks if an automobile was speeding
# and the whole application uses the metric system.
# Your boss tells you that you will be integrating with an external application
# that uses the imperial system.
#
# Ru: Представьте, что вы работаете над приложением, которое проверяет, превысил
# ли автомобиль скорость, и все приложение использует метрическую систему.
# Ваш начальник сообщает вам, что вы будете интегрироваться с внешним
# приложением, использующим имперскую систему.
#
#
# EN: This is the Speed class, it contains the speed value and the unit
#
# RU: Это класс скорости, он содержит значение скорости и единицу
#
class Speed
  include Comparable
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def unit
    raise NotImplementedError,
          "#{self.class} has not implemented method '#{__method__}'"
  end

  # EN: We raise an error if we try to compare speeds with different units
  #
  # RU: Мы поднимаем ошибку, если попытаемся сравнивать скорости с разными единицами
  #
  def <=>(other)
    raise 'The speeds have different units' if unit != other.unit

    value <=> other.value
  end
end

# EN: This is the class that is most used in the internal system.
#
# RU: Это класс, который наиболее используется во внутренней системе.
#
class KilometersSpeed < Speed
  def unit
    'km/h'
  end
end

# EN: This is the type of data you will receive from the external API
#
# RU: Это тот тип данных, которые вы получите от внешнего API
#
class MilesSpeed < Speed
  def unit
    'mi/h'
  end
end

# EN: This class checks if the speed is above or bellow the maximum limit
#
# RU: Этот класс проверяет, если скорость выше или ниже максимального предела
#
class KilometersSpeedLimit
  MAX_LIMIT = KilometersSpeed.new(100)

  def self.speeding?(speed)
    if speed > MAX_LIMIT
      puts "(#{speed.value}#{speed.unit}) You are speeding"
    else
      puts "(#{speed.value}#{speed.unit}) You are bellow the max limit"
    end
  end
end

# EN: This is the adaptor that converts the speed from miles per hour to
# kilometers per hour
#
# RU: Это адаптер, который преобразует скорость с миль в час в километры в час
#
class KilometersAdaptor < MilesSpeed
  def initialize(speed)
    @value = speed.value * 1.61
  end

  def unit
    'km/h'
  end
end

# EN: This is an example of usage in a real application.
# These are the objects you would have inside your application.
#
# RU: Это пример использования в реальном приложении.
# Это те объекты, которые вы бы имели в вашем приложении.
#
slow_km_speed = KilometersSpeed.new(90)
fast_km_speed = KilometersSpeed.new(110)

KilometersSpeedLimit.speeding?(slow_km_speed)
KilometersSpeedLimit.speeding?(fast_km_speed)

# EN: These would be the objects you generate from the data you received from
# the external API.
#
# RU: Это будут объекты, которые вы генерируете из данных, полученных от
# внешнего API.
#
slow_mi_speed = MilesSpeed.new(50)
fast_mi_speed = MilesSpeed.new(80)

slow_mi_adaptor = KilometersAdaptor.new(slow_mi_speed)
fast_mi_adaptor = KilometersAdaptor.new(fast_mi_speed)

KilometersSpeedLimit.speeding?(slow_mi_adaptor)
KilometersSpeedLimit.speeding?(fast_mi_adaptor)
