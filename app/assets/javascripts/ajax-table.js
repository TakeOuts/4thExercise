$('a[class="ShowAllButton"]').on('click', function(event){
    event.preventDefault();
    // AJAX
    $.ajax({
      url: "/getEvents", // Route to the Script Controller method
      type: "GET",
      dataType: "html",
      complete: function() {},
      success: function(data, textStatus, xhr) {
        // Do something with the response here
        $("#selectedDate").html(data);
      },
      error: function(jqXHR, textStatus, errorThrown) {
         console.log(textStatus, errorThrown);
       }
    });
  });
  $(document).ready(function() {
    $('#calendar').fullCalendar({
      defaultDate: '2014-07-03',
      editable: true,
      events: '/showAll.json',
      dayClick: function (date) {
        $.ajax({
          url: "/getEvents?date="+date.format(), // Route to the Script Controller method
          type: "GET",
          dataType: "html",
          complete: function() {},
          success: function(data, textStatus, xhr) {
            // Do something with the response here
            $("#selectedDate").html(data);
          },
          error: function(jqXHR, textStatus, errorThrown) {
             console.log(textStatus, errorThrown);
           }
        });
      }
    });
  });