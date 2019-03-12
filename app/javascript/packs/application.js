import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import 'select2/dist/css/select2.css'

import { initMapbox } from '../plugins/init_mapbox';
import { getLocation } from '../component/get_location'
import { searchType } from '../component/search_type'
import { dropdown } from '../component/dropdown'
import { hideNotice } from '../component/hide_notice'
import { initAutocomplete } from '../plugins/init_autocomplete';
import { initCalendar } from '../plugins/init_calendar.js';
import { fullCalendar } from 'fullcalendar';
import { initSelect2 } from '../plugins/init_select2';

initMapbox();
getLocation();
hideNotice();
initAutocomplete();
initSelect2();


export { fullCalendar };

if (document.querySelector('.cards-list')) {
  document.querySelector('.footer').classList.add('d-none');
}
