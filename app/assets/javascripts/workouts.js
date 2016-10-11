
$(document).ready(function() {
   $("#calendar").fullCalendar({
     header: {
       left: "prev,next today",
       center: "title",
       right: "month,agendaWeek,agendaDay"
     },
     defaultView: "month",
     height: 500,
     slotMinutes: 15,
     events: "/workouts/get_workouts/?search1="+$("#category-search").html()+ "&search2="+$("#level-search").html()+"&search3="+$("#instructor-search").html(),
     timeFormat: "LT",
     dragOpacity: "0.5",
     eventClick:  function(event, jsEvent, view) {
         $('#modalTitle').html(event.title);
         $('#instructor').attr('href',event.link);
         $('#instructor').html(event.instructor);
         $('#description').html(event.description);
         $('#location').html(event.location);
         $('#date').html(event.date);
         $('#time').html(event.time);
         $('#category').html(event.category);
         $('#duration').html(event.duration);
         $('#level').html(event.level);
         $('#image').attr("src", event.image);
         $('#eventUrl').attr('href',event.url);
         $('#fullCalModal').modal();
         return false;
     }
  });

  $('#search').click(function(){
    $('#calendar').fullCalendar( 'removeEvents' );
    var events = {
      url: "/workouts/get_workouts/?search1="+document.getElementById('search-category').value+ "&search2="+document.getElementById('search-level').value+"&search3="+document.getElementById('search-instructor').value
    }
    $('#calendar').fullCalendar( 'removeEventSource', events);
    $('#calendar').fullCalendar( 'addEventSource', events);
    $('#calendar').fullCalendar( 'rerenderEvents' );
  }).change();

});
