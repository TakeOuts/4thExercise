#encoding: utf-8
class Note < ActiveRecord::Base
  # Валидация соотвествующих полей
  validates :title, :presence => {:message => 'Пропущено название'}, length: { minimum: 5, :too_short => "должен содержать не менее %{count} символов" } # Проверка на не пустоту и минимальную длину текста
  validates :description, :presence => {:message => 'Пропущено описание'}, length: { minimum: 5, :too_short => "должен содержать не менее %{count} символов" } # Проверка на не пустоту и минимальную длину текста
  validate  :valid_date? # Проверка на не пустоту и неверный формат с помощью вспомогательной функции
  validates :priority, :presence => {:message => 'Пропущен приоритет'}, # Проверка на не пустоту
    :numericality => { :greater_than_or_equal_to => 0, :message => "Введено невалидное значение" }, # Проверка того, что значение является целочисленным и оно не меньше 0. 
    length: { minimum: 1, :too_short => "должен содержать не менее %{count} символов" } # Проверка на минимальную длину текста  
  
  # Вспомогательная функция для валидации даты
  def valid_date?
    # Проверка на не пустоту
    if eventDate.present?
      # Если дата может быть сконвертирована в DataTime формат
      unless eventDate.is_a?(Time)
        errors.add(:eventDate, "Неверный формат даты")
      end
      else
        errors.add(:eventDate, "Дата не введена")
    end  
  end
end
