import fullCalendar from 'fullcalendar';

const initCalendar = () => {
  $('#calendar').fullCalendar({
    locale: 'pt-BR'
  });
};

export { initCalendar };
