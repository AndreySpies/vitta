import fullCalendar from 'fullcalendar';

const initCalendar = () => {
  $('#calendar').fullCalendar({
    locale: 'pt-BR',
    buttonText: {
      today: 'hoje',
      month: 'mês',
      day: 'dia'
    }
  });
};

export { initCalendar };
