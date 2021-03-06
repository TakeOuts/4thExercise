class NotesController < ApplicationController
  # Action new создает новую переменную экземпляра по имени @note
  # Представление для этого экшна расположено в app/views/notes/new.html.erb
  def new
    # Инициализация пустого экземпляра
    @note = Note.new
  end
  
  # Вызывается при отправке заполненой формы во время создании новой записи.
  def create
    # Инициализаия экземпляра осуществляется с помощью атрибутов, которые содержатся в параметрах запроса к текущему контроллеру
    # Метод note_params используется в целях безопасности
    @note = Note.new(note_params)
    
    # Сохранение изменений
    # Если метод save вернул true, то производится редирект на страницу только что созданной записи.
    if @note.save
      redirect_to @note
    # В противном случае заново загружается страница создания новой записи
    else
      render 'new'
    end
  end
  
  # Данный экшн создает выборку элементов за текущую дату
  # Представление для этого экшна расположено в app/views/notes/index.html.erb
  def index
    @notes = Note.where(eventDate: Time.now.to_date..(Time.now.to_date+1))
  end
  
  # show отвечает за отображение данных элемента, id которого содержится в параметрах запроса
  def show
    @note = Note.find_by_id(params[:id])
    
    # Если записей с таким :id не найдено, то вопспользуемся вспомогательным методом render_404, который выдает 404 ошибку
    if @note.nil?
      render_404
    end      
  end
  
  # showAll отвечает за отображение информации обо всех элементах в JSON представлении
  # Представление для этого экшна расположено в app/views/notes/showAll.json.jbuilder
  # Адрес: /showAll.json
  def showAll
    @notes = Note.all
    
    # Если список записей пуст, то производим редирект на страницу 404-ошибки
    if @notes.empty?
      render_404
    end 
  end
  
  # update отвечает за изменение данных элемента, id которого содержится в параметрах запроса.
  # При этом, метод вносит новые данные, которые были получены из параметров запроса к этому экшену, в выбранный элемент  
  def update
    @note = Note.find_by_id(params[:id])
    
    # Если записей с таким :id не найдено, то вопспользуемся вспомогательным методом render_404, который выдает 404 ошибку
    if @note.nil?
      render_404
    end
    
    # Если метод update вернул true, то производится редирект на страницу только что измененной записи.
    if @note.update(note_params)
      redirect_to @note
    # В противном случае заново загружается страница изменения записи
    else
      render 'edit'
    end
  end
  
  # Экшн destroy найдет элемент, который был выбран и удалит его
  def destroy
    @note = Note.find_by_id(params[:id])
    
    # Если записей с таким :id не найдено, то вопспользуемся вспомогательным методом render_404, который выдает 404 ошибку
    if @note.nil?
      render_404
    end
    @note.destroy
    
    # Редирект на главную страницу
    redirect_to notes_path
  end
  
  # edit отвечает за изменение данных элемента, который нужно изменить и id которого содержится в параметрах запроса.
  # Представление для этого экшна расположено в app/views/notes/edit.html.erb
  def edit
    @note = Note.find_by_id(params[:id])
    
    # Если записей с таким :id не найдено, то вопспользуемся вспомогательным методом render_404, который выдает 404 ошибку
    if @note.nil?
      render_404
    end
  end
  
  # Создает выборку элементов, которые удовлетворяют критериям поиска
  def getEvents
    # Если запрос содержит параметр date, то осуществляем поиск по этому критерию
    unless params[:date].nil?
      selectedDate = Time.parse(params[:date])
      @notes = Note.where(eventDate: selectedDate.to_date..(selectedDate.to_date+1))
    # В противном случае выводим все данные
    else
      @notes = Note.all
    end
    
    # Информация будет возвращена в частичном представлении (т.е отсутствует часть за которую отвечает layout)
    respond_to do |format|
      format.html { render 'showList', :layout => false }
    end
  end
private
# Данный метод предотвращает изменение атрибутов модели злоумышленником
  def note_params
    params.require(:note).permit(:title, :description, :eventDate, :priority)
  end
  
  # render_404 формирует страницу ответа, который содержит 404 ошибку
  def render_404
    respond_to do |format|
      # В качестве представления используется страница /public/404, к которой не применяются layout'ы
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end