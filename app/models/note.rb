class Note < ActiveRecord::Base
  # Валидация соотвествующих полей
  validates :title, presence: true, length: { minimum: 5 } # Проверка на не пустоту и минимальную длину текста
  validates :description, presence: true, length: { minimum: 5 } # Проверка на не пустоту и минимальную длину текста
  validates :eventDate, presence: true # Проверка на не пустоту
  validates :priority, presence: true, length: { minimum: 1 } # Проверка на не пустоту и минимальную длину текста
end
