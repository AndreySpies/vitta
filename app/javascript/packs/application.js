// import 'jquery';
// import 'jquery-ujs';
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
// import 'bootstrap-wysihtml5';

import {getLocation} from '../component/get_location'
import { searchType } from '../component/search_type'
import { dropdown } from '../component/dropdown'

import { initAutocomplete } from '../plugins/init_autocomplete';
import { initMapbox } from '../plugins/init_mapbox';

getLocation();

initAutocomplete();
initMapbox();

