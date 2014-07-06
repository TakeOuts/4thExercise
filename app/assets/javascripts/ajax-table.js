// Содержит обработчики событий нажатия на кнопку "Показать все" и любую дату
$(document).ready(function() {
    $('a[class="ShowAllButton"]').on('click', function(event){
        event.preventDefault();
        $.ajax({
            url: "/getEvents",
            type: "GET",
            dataType: "html",
            complete: function() {},
            success: function(data, textStatus, xhr) {
                $("#selectedDate").html(data);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    });
    $('#calendar').fullCalendar({
        header: { // Формат заголовка календаря
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultDate: '2014-07-07', // Текущая дата
        firstDay: 1, // Начало недели
        timeFormat: 'H:mm', // Формат времени в превью записи
        editable: true,
        events: '/showAll.json', // Откуда подгружаются данные
        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                monthNamesShort: ['Янв.','Фев.','Март','Апр.','Май','Июнь','Июль','Авг.','Сент.','Окт.','Ноя.','Дек.'],
                dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
                dayNamesShort: ["ВС","ПН","ВТ","СР","ЧТ","ПТ","СБ"],
                buttonText: {
                    prev: "<",
                    next: ">",
                    prevYear: "<",
                    nextYear: ">",
                    today: "Сегодня",
                    month: "Месяц",
                    week: "Неделя",
                    day: "День"
                }, // Русская версия
        dayClick: function (date) { // Событие клика на любой день
            $.ajax({
                url: "/getEvents?date="+date.format(), // Route to the Script Controller method
                type: "GET",
                dataType: "html",
                complete: function() {},
                success: function(data, textStatus, xhr) {
                    $("#selectedDate").html(data);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        }
    });
});